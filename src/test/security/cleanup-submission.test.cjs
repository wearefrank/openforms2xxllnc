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

test('verified cleanup can complete when a document was already deleted', () => {
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

const forwardPath = (name, outcome) => Array.from(pipe(name).getElementsByTagName('Forward'))
    .find(forward => forward.getAttribute('name') === outcome).getAttribute('path');

test('ownership verification is read-only and commits evidence to a separate queue', () => {
    const adapter = configuration.getElementsByTagName('Adapter')[0];
    const pipeline = adapter.getElementsByTagName('Pipeline')[0];
    const firstPipe = Array.from(pipeline.childNodes).find(node => node.nodeType === 1 && node.tagName !== 'Exits');
    assert.equal(firstPipe.getAttribute('name'), 'ValidateCleanupTargets');
    assert.equal(forwardPath('ValidateCleanupTargets', 'then'), 'VerifySourceDocuments');
    assert.equal(forwardPath('CheckDocumentAssociation', 'then'), 'EXIT');
    assert.equal(forwardPath('CheckDocumentAssociation', 'else'), 'CleanupFailed');
    assert.equal(forwardPath('VerifySourceDocuments', 'success'), 'QueueVerifiedCleanup');
    assert.equal(pipe('VerifySourceDocuments').getAttribute('collectResults'), 'true');
    assert.equal(pipe('VerifySourceDocuments').getAttribute('storeResultInSessionKey'), 'VerifiedOwnership');
    assert.equal(pipe('QueueVerifiedCleanup').getAttribute('getInputFromSessionKey'), 'originalMessage');
    const sender = pipe('VerifiedCleanupMessageStoreSender');
    const receiver = configuration.getElementsByTagName('MessageStoreListener')[1];
    assert.equal(sender.getAttribute('sessionKeys'), 'VerifiedOwnership');
    assert.equal(sender.getAttribute('transacted'), 'true');
    assert.equal(sender.getAttribute('slotId'), receiver.getAttribute('slotId'));
    assert.equal(sender.getAttribute('sessionKeys'), receiver.getAttribute('sessionKeys'));
    const verifier = Array.from(configuration.getElementsByTagName('Adapter'))
        .find(element => element.getAttribute('name') === 'VerifySourceDocument');
    for (const sender of Array.from(verifier.getElementsByTagName('HttpSender'))) {
        assert.equal(sender.getAttribute('methodType'), 'GET');
    }
    assert.equal(adapter.getElementsByTagName('HttpSender').length, 0);
});

test('persisted evidence must prove ownership of every target before source removal', () => {
    const verifiedVariables = { ...roots, SourceObjectUrl: source, Evidence: parse(relation()) };
    assert.equal(evaluate('ValidateVerifiedOwnership', message(), verifiedVariables), true);
    assert.equal(evaluate('ValidateVerifiedOwnership', message(), { ...verifiedVariables, Evidence: parse('<root/>') }), false);
    assert.equal(evaluate('ValidateVerifiedOwnership', message(), { ...verifiedVariables, Evidence: parse(relation(document, source + '0')) }), false);
    assert.equal(evaluate('ValidateVerifiedOwnership', message(source, document + '0'), verifiedVariables), false);
    assert.equal(evaluate('ValidateVerifiedOwnership', message(), { ...verifiedVariables, DocumentsRoot: 'https://other.example/' }), false);
    assert.equal(pipe('ValidateVerifiedOwnership').getElementsByTagName('Param')[3].getAttribute('sessionKey'), 'VerifiedOwnership');
});

test('owning backend removes the source before checking document blockers', () => {
    assert.equal(forwardPath('ValidateVerifiedOwnership', 'then'), 'GetObjectsAuthorization');
    assert.equal(forwardPath('GetObjectsAuthorization', 'success'), 'DeleteSourceObject');
    assert.equal(forwardPath('CheckObjectDeletion', 'then'), 'DeleteSourceDocuments');
    assert.equal(forwardPath('CheckObjectDeletion', 'else'), 'CleanupFailed');
    assert.equal(forwardPath('DeleteSourceDocuments', 'success'), 'EXIT');
    assert.equal(forwardPath('CheckDocumentAbsent', 'else'), 'CheckDocumentReadable');
    assert.equal(forwardPath('CheckDocumentReadable', 'then'), 'GetBlockingRelations');
    assert.equal(forwardPath('CheckNoBlockingRelations', 'then'), 'DeleteDocument');
    assert.equal(forwardPath('CheckNoBlockingRelations', 'else'), 'CleanupFailed');
    for (const status of ['204', '404', '410']) {
        assert.equal(evaluate('CheckObjectDeletion', '<dummy/>', { Status: status }), true);
    }
    for (const sender of Array.from(configuration.getElementsByTagName('HttpSender'))) {
        if (sender.getAttribute('name').includes('Relations') || sender.getAttribute('name').includes('Association')) {
            assert.equal(sender.getAttribute('methodType'), 'GET');
        }
    }
});

test('blocking lookup includes relations from all objects, not just the source', () => {
    const urlParameter = pipe('GetBlockingRelationsHttpSender').getElementsByTagName('Param')[0];
    const url = new URL(evaluateXPathToString(urlParameter.getAttribute('xpathExpression'),
        parse('<dummy/>'), null, { ...roots, ...variables }));
    assert.equal(url.origin, 'https://documents.example');
    assert.equal(url.searchParams.get('informatieobject'), document);
    assert.equal(url.searchParams.has('object'), false);
});

test('only an explicitly empty complete relation list permits deletion', () => {
    const empty = '<root><count>0</count><next/><results/></root>';
    assert.equal(evaluate('CheckNoBlockingRelations', empty, { Response: '{"count":0,"results":[]}' }), true);
    assert.equal(evaluate('CheckNoBlockingRelations', '<root/>', { Response: '[ \n ]' }), true);
    assert.equal(evaluate('CheckNoBlockingRelations', '<root/>', { Response: '{}' }), false);
    assert.equal(evaluate('CheckNoBlockingRelations', '<root/>', { Response: '[]garbage' }), false);
    assert.equal(evaluate('CheckNoBlockingRelations', '<root><count>1</count><results/></root>', { Response: '{}' }), false);
    assert.equal(evaluate('CheckNoBlockingRelations', relation(document, 'other'), { Response: '{}' }), false);
    assert.equal(evaluate('CheckNoBlockingRelations', '<root><count>0</count><next>https://documents.example/page2</next></root>', { Response: '{}' }), false);
    assert.equal(evaluate('CheckNoBlockingRelations', '<root><count>0</count><results><informatieobject>other</informatieobject></results></root>', { Response: '{}' }), false);
});

test('blocking lookup failures fail closed', () => {
    assert.equal(pipe('CheckBlockingRelationsResponse').getAttribute('getInputFromFixedValue'), '<dummy/>');
    assert.equal(pipe('GetBlockingRelations').getAttribute('storeResultInSessionKey'), 'BlockingRelationsResponse');
    assert.equal(pipe('BlockingRelationsJsonToXml').getAttribute('getInputFromSessionKey'), 'BlockingRelationsResponse');
    for (const status of ['301', '403', '404', '500']) {
        assert.equal(evaluate('CheckBlockingRelationsResponse', '<dummy/>', { Status: status }), false);
    }
});

test('both cleanup stages are covered by the existing retry scheduler', () => {
    const scheduler = parse(fs.readFileSync(path.join(__dirname,
        '../../main/configurations/xxllnc/Configuration_RetryScheduler.xml'), 'utf8'));
    const sender = Array.from(scheduler.getElementsByTagName('FixedQuerySender'))
        .find(element => element.getAttribute('name') === 'RetryCleanupMessagesFixedQuerySender');
    const parameters = Array.from(sender.parentNode.getElementsByTagName('Param'));
    const slots = parameters.filter(parameter => parameter.getAttribute('name') !== 'maxRetries')
        .map(parameter => parameter.getAttribute('value'));
    for (const listener of Array.from(configuration.getElementsByTagName('MessageStoreListener'))) {
        assert.ok(slots.includes(listener.getAttribute('slotId')));
    }
    assert.ok(sender.getAttribute('query').includes('SLOTID IN (?{slotId}, ?{verifiedSlotId})'));
    assert.ok(sender.getAttribute('query').includes('COALESCE(CAST(LABEL AS NUMERIC), 0) < ?{maxRetries}'));
});