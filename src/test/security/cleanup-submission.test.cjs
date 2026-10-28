const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { test } = require('node:test');
const { DOMParser } = require('@xmldom/xmldom');
const { evaluateXPathToBoolean, evaluateXPathToString } = require('fontoxpath');

const parse = xml => new DOMParser().parseFromString(xml, 'text/xml');
const configuration = parse(fs.readFileSync(path.join(__dirname,
    '../../main/configurations/xxllnc/Configuration_Handler_CleanupSubmissionCommand.xml'), 'utf8'));
const pipe = name => Array.from(configuration.getElementsByTagName('*'))
    .find(element => element.getAttribute('name') === name);
const evaluate = (name, xml, variables) => evaluateXPathToBoolean(
    pipe(name).getAttribute('xpathExpression'), parse(xml), null, variables);
const source = 'https://objects.example/api/v2/objects/11111111-1111-1111-1111-111111111111';
const document = 'https://documents.example/api/v1/enkelvoudiginformatieobjecten/22222222-2222-2222-2222-222222222222';
const roots = {
    ObjectsRoot: 'https://objects.example/api/v2/',
    DocumentsRoot: 'https://documents.example/api/v1/'
};
const variables = { SourceDocumentUrl: document, SourceObjectUrl: source };
const message = (object = source, target = document) =>
    `<Command><SourceObjectUrl>${object}</SourceObjectUrl><url>${target}</url></Command>`;
const relation = (target = document, object = source, type = 'overige') =>
    `<root><results><informatieobject>${target}</informatieobject><object>${object}</object><objectType>${type}</objectType></results></root>`;

test('canonical trusted cleanup targets are accepted', () => {
    assert.equal(evaluate('ValidateCleanupTargets', message(), roots), true);
});

for (const [name, target] of Object.entries({
    'foreign origin': document.replace('documents.example', 'attacker.example'),
    'host suffix spoof': document.replace('documents.example', 'documents.example.attacker.example'),
    'userinfo spoof': document.replace('documents.example', 'documents.example@attacker.example'),
    'encoded traversal': document + '/%2e%2e/other',
    'path traversal': document + '/../other',
    'query override': document + '?version=1',
    'fragment': document + '#other',
    'wrong resource': document.replace('enkelvoudiginformatieobjecten', 'objectinformatieobjecten'),
    'blank target': ''
})) {
    test(`cleanup rejects ${name}`, () => {
        assert.equal(evaluate('ValidateCleanupTargets', message(source, target), roots), false);
    });
}

test('cleanup rejects untrusted or missing source objects and unconfigured roots', () => {
    assert.equal(evaluate('ValidateCleanupTargets', message(source.replace('objects.example', 'attacker.example')), roots), false);
    assert.equal(evaluate('ValidateCleanupTargets', message(''), roots), false);
    assert.equal(evaluate('ValidateCleanupTargets', message(), { ObjectsRoot: '', DocumentsRoot: '' }), false);
});

test('only an exact document-to-source-object relation permits deletion', () => {
    assert.equal(evaluate('CheckDocumentAssociation', relation(), variables), true);
    assert.equal(evaluate('CheckDocumentAssociation', relation(document + '0'), variables), false);
    assert.equal(evaluate('CheckDocumentAssociation', relation(document, source + '0'), variables), false);
    assert.equal(evaluate('CheckDocumentAssociation', relation(document, source, 'zaak'), variables), false);
    assert.equal(evaluate('CheckDocumentAssociation', '<root><results/></root>', variables), false);
    assert.equal(evaluate('CheckDocumentAssociation', `<root>
        <results><informatieobject>${document}</informatieobject><object>other</object><objectType>overige</objectType></results>
        <results><informatieobject>other</informatieobject><object>${source}</object><objectType>overige</objectType></results>
        </root>`, variables), false);
});

test('lookup failures cannot authorize deletion', () => {
    assert.equal(pipe('CheckAssociationResponse').getAttribute('getInputFromFixedValue'), '<dummy/>');
    assert.equal(pipe('GetDocumentAssociation').getAttribute('storeResultInSessionKey'), 'DocumentAssociationResponse');
    assert.equal(pipe('DocumentAssociationJsonToXml').getAttribute('getInputFromSessionKey'), 'DocumentAssociationResponse');
    for (const status of ['301', '302', '403', '404', '500']) {
        assert.equal(evaluate('CheckAssociationResponse', '<dummy/>', { Status: status }), false);
    }
    assert.equal(evaluate('CheckAssociationResponse', '<dummy/>', { Status: '200' }), true);
});

test('only absent documents can complete cleanup without an association', () => {
    for (const status of ['404', '410']) {
        assert.equal(evaluate('CheckDocumentAbsent', '<dummy/>', { Status: status }), true);
    }
    assert.equal(evaluate('CheckDocumentAbsent', '<dummy/>', { Status: '200' }), false);
});

test('cleanup HTTP senders never follow redirects', () => {
    for (const sender of Array.from(configuration.getElementsByTagName('HttpSender'))) {
        assert.equal(sender.getAttribute('followRedirects'), 'false', sender.getAttribute('name'));
    }
});

test('association lookup binds both exact URLs on the trusted API', () => {
    const urlParameter = Array.from(pipe('GetDocumentAssociationHttpSender').getElementsByTagName('Param'))
        .find(element => element.getAttribute('name') === 'url');
    const url = new URL(evaluateXPathToString(urlParameter.getAttribute('xpathExpression'),
        parse('<dummy/>'), null, { ...roots, ...variables }));
    assert.equal(url.origin, 'https://documents.example');
    assert.equal(url.searchParams.get('object'), source);
    assert.equal(url.searchParams.get('informatieobject'), document);
});

test('cleanup validates targets first and retains the source object until documents finish', () => {
    const adapter = configuration.getElementsByTagName('Adapter')[0];
    const pipeline = adapter.getElementsByTagName('Pipeline')[0];
    const firstPipe = Array.from(pipeline.childNodes).find(node => node.nodeType === 1 && node.tagName !== 'Exits');
    assert.equal(firstPipe.getAttribute('name'), 'ValidateCleanupTargets');
    assert.equal(pipe('DeleteSourceDocuments').getElementsByTagName('Forward')[0].getAttribute('path'), 'GetObjectsAuthorization');
    const associationForwards = Array.from(pipe('CheckDocumentAssociation').getElementsByTagName('Forward'));
    assert.equal(associationForwards.find(forward => forward.getAttribute('name') === 'then').getAttribute('path'), 'DeleteDocument');
    assert.equal(associationForwards.find(forward => forward.getAttribute('name') === 'else').getAttribute('path'), 'CheckDocumentAlreadyDeleted');
});