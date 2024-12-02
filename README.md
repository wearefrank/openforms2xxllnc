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

## Local Development Docusaurus
1. Navigate to "docusaurus" subfolder with `cd ./docusaurus`.
2. Install dependencies with `npm install`.
3. Serve Docusaurus webserver locally with `docusaurus start`. By default it is served at `http://localhost:3000/`.
4. Basic guide on how to use Docusaurus and a styleguide can be found at `./docusaurus/docs/_README.md`.

#### Update Docusaurus dependencies
1. Navigate to "docusaurus" subfolder with `cd ./docusaurus`.
2. Update dependencies with `npm i @docusaurus/core@latest @docusaurus/preset-classic@latest @docusaurus/module-type-aliases@latest @docusaurus/tsconfig@latest @docusaurus/types@latest`.