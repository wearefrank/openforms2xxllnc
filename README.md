# Openforms2xxllnc

An integration connecting [Open-forms](https://github.com/open-formulieren/open-forms) as adding extra documents into the existing cases to the ZDS back-end system. The integration can be configured to host an "Objects API" endpoint that can be configured in Open-forms as "Objects API" registration back-end. Alternatively the integration can be configured to retrieve the object from an "Objects API" when triggered by a notification from the "Notificatie API". This integration does not create a new case but just add the extra documents to the existing cases. Only authorized with DigiD or E-Herkenning users can add extra document to their existing cases.

This integration leverages [Frank!Framework](https://github.com/frankframework/frankframework) and its debugger [Ladybug](https://github.com/wearefrank/ladybug). Ladybug shows for each incoming request the exact steps that were executed to process the message in great detail. If there are errors, this information can be used for easy debugging.

Features:
- Objects API endpoint to configure as registration back-end in Open-forms.
- Notificatie API callback endpoint to retrieve the object given in the notification.
- Filter notifications based on configurable "producttype".
- Register Notificatie API callback endpoint with Notificatie API (subscribe).
- Support for person only with DigiD.
- Support for organisation only with E-Herkenning.
- Fetch exiting case from ZDS.
- Add Open-forms form result pdf case.
- Retrieve form attachments from Documenten API, add document metadata to the case with the Exxellence "document-service", upload the filedata to the document vault with the "mtom-service" and mark the document as uploaded to the vault with the "BasicStatusUpdate-service".
- Translate JSON formdata to XML and add it to the case.
- Automatically prepend JSON key-names that result in llegal element names in XML.

# System
### Option 1: Notification API - object created notification
![ZGW API's](./docs/openforms2bpel-system-notification-api.drawio.svg)
### Option 2: Objects API objects_create endpoint as registration backend
![ZGW API's](./docs/openforms2bpel-system-objects-api.drawio.svg)
### Option 3: ZGW API's as registration backend (Partially implemented)
![ZGW API's](./docs/openforms2bpel-system-zgw-apis.drawio.svg)

# Usage

### Running with Docker
Ensure that Docker is installed on your computer and proceed as follows:

1. Clone GitHub project https://github.com/wearefrank/openforms2xxllnc if you have not done so yet.
2. Open a command prompt and change directory to the checkout directory.
3. Build your Docker image from the source code using a command like the following: `docker build -t openforms2xxllnc:local .`.
4. Run Openforms2bpel using a command like the following: `docker run -p 8080:8080 -e dtap.stage=LOC --name=openforms2xxllnc openforms2xxllnc:local`.
5. To see the openforms2xxllnc integration running in the Frank!Console, open a webbrowser and visit http://localhost:8080.

# Local Development

## Source Cleanup

After every document has received a StUF `Bv03` acknowledgement, the integration queues a separate `CleanupSubmissionCommand`. It validates all cleanup targets and verifies each distinct attachment/result-PDF resource's ownership. Only after every document is verified does it commit the original cleanup targets and the API's ownership evidence to the internal `VerifiedCleanupSubmissionCommand` queue. This verification stage performs no external deletions. Rejected submissions and failed uploads do not queue cleanup. Notifications other than `create` are ignored, including notifications caused by cleanup.

Configure the trusted API roots, including their trailing slashes, before enabling cleanup:

```properties
openforms2xxllnc.connections.objects-api.root-url=https://objects.example/api/v2/
openforms2xxllnc.connections.documenten-api.root-url=https://documents.example/api/v1/
```

Cleanup only accepts canonical UUID resource URLs beneath these roots. Before persisting verified cleanup, it queries the trusted Documenten API's `objectinformatieobjecten` endpoint and requires a relation with the exact document URL, source object URL, and `objectType=overige`. The registration backend must create these relations independently of the submitted attachment fields; copying URLs from the submission is not ownership proof. Redirects are disabled for all cleanup HTTP requests.

The verified stage restores and validates the persisted ownership evidence, then requests deletion of the source object through its owning Objects API backend. That backend must synchronize removal of its Documenten API relations when the object is deleted. This integration does not call the Documenten API's relation DELETE endpoint, which is reserved for synchronization by owning backends. Before each document DELETE, it checks all relations for that document, without filtering by source object, and requires an explicitly empty, complete result. Remaining relations, pending asynchronous synchronization, pagination, and lookup failures block document deletion. Relations owned by other objects are never removed by this integration.

Missing roots, missing source object URLs (including direct Objects API submissions), and missing ownership relations fail closed into verification error storage without deleting anything. Deployments without ownership relations or owning-backend synchronization must retain their documents until these prerequisites are available. The internal verified queue is trusted storage: do not expose it to submission callers or manually inject ownership evidence.

The configured Objects API and Documenten API credentials need DELETE permissions, plus read access to document associations and document metadata. Cleanup accepts HTTP 200/204 and treats 404/410 as already deleted. A verified-stage retry uses the previously committed evidence, so it can recover after source deletion, relation removal, or a partial document deletion. Failures remain in the corresponding stage's error storage (`Handler_CleanupSubmissionCommand` or `Handler_VerifiedCleanupSubmissionCommand`). Retry the failed stage's message with its stored context intact, not the original submission or upload command: external deletions cannot be rolled back, and retrying an upload can duplicate case documents. The retry scheduler covers both cleanup queues using the same configured retry limit.

Automatic cleanup retries follow the existing `openforms2xxllnc.workflows.auto-retries` defaults (disabled by default). Override these properties to configure cleanup independently:

```properties
openforms2xxllnc.workflows.auto-retries.cleanup-submission.enabled=true
openforms2xxllnc.workflows.auto-retries.cleanup-submission.cron-expression=0 0/30 * * * ?
openforms2xxllnc.workflows.auto-retries.cleanup-submission.max-retries=5
```

### Manual Cleanup Tests

The notification fixture generates canonical UUID document URLs. The Documenten API mock returns fixture-owned `objectinformatieobjecten` relations until the Objects API mock successfully deletes the source, then returns an empty list for blocker checks. Configure the integration to trust the mock roots:

```properties
openforms2xxllnc.connections.objects-api.root-url=http://host.docker.internal:8089/mock/objects/api/v2/
openforms2xxllnc.connections.documenten-api.root-url=http://host.docker.internal:8700/mock/documenten/api/v1/
```

Use the `notificaties HappyFlowPersoon` case in `e2e/SoapUI/openforms2xxllnc-e2e-soapui-project.xml`, with all five mock services running and the local SoapUI global property `notificationAuthorization` configured. Run cases sequentially because the mocks share project properties.

- Happy flow: the test verifies the object fetch, two StUF uploads, and object/document DELETE calls. Inspect both cleanup adapters in Ladybug for the individual HTTP results.
- Cleanup failure: set the test-case property `cleanupDocumentStatus` to `500` and run the case. Its final assertion should fail. Restore the **project** property `cleanupDocumentStatus` to `204`, manually retry only the verified cleanup error-store message with its ownership evidence intact, then rerun only the final verification step. The upload count must remain two. The equivalent `cleanupObjectStatus` property simulates an object DELETE failure.
- Already deleted: first let ownership verification commit its evidence, then simulate source/document GET responses of `404` on a verified-stage retry. Cleanup should succeed without requiring the removed ownership relation again.
- Blocking relations: keep a relation after source deletion, including one owned by another object. No document DELETE may occur. After the owning backend synchronizes its removal, retry the verified-stage message; it must not upload again or re-verify against a now-removed source relation.
- Upload failure: temporarily make the StUF upload mock return an error acknowledgement instead of `Bv03`. No source DELETE calls should occur; restore the mock afterwards.
- Duplicate URLs: temporarily use the same URL for the fixture's attachment and result PDF. Both existing upload calls can occur, but cleanup must DELETE that source document only once; inspect the mock log rather than using the two-distinct-documents assertion.

### Cleanup Guard Regression Tests

Run the configuration's XPath security checks with Node.js. In PowerShell, install the test dependencies outside the repository and run:

```powershell
npm install --prefix "$env:TEMP/openforms-cleanup-xpath-tests" --no-save --package-lock=false fontoxpath @xmldom/xmldom
$env:NODE_PATH = "$env:TEMP/openforms-cleanup-xpath-tests/node_modules"
node --test src/test/security/cleanup-submission.test.cjs
```

With Groovy installed, run the association mock regression checks from the repository root:

```powershell
groovy src/test/security/soapui-association-mock.test.groovy
```

## Local Development Docusaurus
1. Navigate to "docusaurus" subfolder with `cd ./docusaurus`.
2. Install dependencies with `npm install`.
3. Serve Docusaurus webserver locally with `docusaurus start`. By default it is served at `http://localhost:3000/`.
4. Basic guide on how to use Docusaurus and a styleguide can be found at `./docusaurus/docs/_README.md`.

#### Update Docusaurus dependencies
1. Navigate to "docusaurus" subfolder with `cd ./docusaurus`.
2. Update dependencies with `npm i @docusaurus/core@latest @docusaurus/preset-classic@latest @docusaurus/module-type-aliases@latest @docusaurus/tsconfig@latest @docusaurus/types@latest`.