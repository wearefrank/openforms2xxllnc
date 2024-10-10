[![conventional commits](https://img.shields.io/badge/conventional%20commits-1.0.0-yellow.svg)](https://conventionalcommits.org) [![semantic versioning](https://img.shields.io/badge/semantic%20versioning-2.0.0-green.svg)](https://semver.org)

## [1.2.1](https://github.com/wearefrank/openforms2xxllnc/compare/v1.2.0...v1.2.1) (2024-10-10)

### 🧑‍💻 Code Refactoring

* include api-key header with dms-zs communication ([#18](https://github.com/wearefrank/openforms2xxllnc/issues/18)) ([56715fd](https://github.com/wearefrank/openforms2xxllnc/commit/56715fd743d8c4e51e57618db057222f62a1eb0d))

## [1.2.0](https://github.com/wearefrank/openforms2xxllnc/compare/v1.1.1...v1.2.0) (2024-09-13)

### 🍕 Features

* two-way communication workflow can be configured to send a noreply email when target case is already closed ([#12](https://github.com/wearefrank/openforms2xxllnc/issues/12)) ([e377219](https://github.com/wearefrank/openforms2xxllnc/commit/e377219059b1d04beb5d6acce8683620b15c7f0d))

## [1.1.1](https://github.com/wearefrank/openforms2xxllnc/compare/v1.1.0...v1.1.1) (2024-09-13)

### 🐛 Bug Fixes

* notificatie-api subscribe request not used as input for subscribe post call ([64f21a9](https://github.com/wearefrank/openforms2xxllnc/commit/64f21a95878051546e572a15a561c20e5914ce6d))

## [1.1.0](https://github.com/wearefrank/openforms2xxllnc/compare/v1.0.2...v1.1.0) (2024-09-13)

### 🍕 Features

* translate forms object to zs-dms geefZaakDetails and voegZaakdocumentToe messages ([#8](https://github.com/wearefrank/openforms2xxllnc/issues/8)) ([03a9882](https://github.com/wearefrank/openforms2xxllnc/commit/03a98824b8b7e42239e3d067d60e6b76caeb2277))

### 🤖 Build System

* **dependencies:** bump wearefrank/ci-cd-templates ([775608b](https://github.com/wearefrank/openforms2xxllnc/commit/775608bcbaf65a989dc22a8b8006a1e608cbbdc0))

## [1.0.2](https://github.com/wearefrank/openforms2xxllnc/compare/v1.0.1...v1.0.2) (2024-09-09)

### 🤖 Build System

* **dependencies:** bump the docusaurus group across 1 directory with 7 updates ([#10](https://github.com/wearefrank/openforms2xxllnc/issues/10)) ([6c6ac2b](https://github.com/wearefrank/openforms2xxllnc/commit/6c6ac2b38b370e0ef865ea655d859840f899f58c))
* **dependencies:** bump the github-actions group across 1 directory with 3 updates ([#3](https://github.com/wearefrank/openforms2xxllnc/issues/3)) ([de1b07a](https://github.com/wearefrank/openforms2xxllnc/commit/de1b07a70bf4dd52fde1f05f10adee82b21df71a))
* **dependencies:** bump wearefrank/ci-cd-templates ([#9](https://github.com/wearefrank/openforms2xxllnc/issues/9)) ([3b7b060](https://github.com/wearefrank/openforms2xxllnc/commit/3b7b0604fce66736be9541e2ba14aad1e5510275))

### 🔁 Continuous Integration

* correct ff version bumper workflow schedule syntax ([7e46af4](https://github.com/wearefrank/openforms2xxllnc/commit/7e46af4bf77daa45bf64a39b7a7a89388fd53592))

## [1.0.1](https://github.com/wearefrank/openforms2xxllnc/compare/v1.0.0...v1.0.1) (2024-08-02)

### 🎨 Styles

* rename and restructure propreties to follow the more intuitive structure and names from the helm chart ([009d703](https://github.com/wearefrank/openforms2xxllnc/commit/009d703b3e4c023d447c3aaa7163aeb297d055b5))

### 🧑‍💻 Code Refactoring

* base error scenarios send mail condition on dedicated send-mail toggle instead of empty mail-template name ([56af0af](https://github.com/wearefrank/openforms2xxllnc/commit/56af0af78a3dfa46c7ad3a09afd49c568db165d1))
* no-reply mail sender adapter follows dedicated no-reply-smtp.enabled toggle for adapter active state ([cc92c88](https://github.com/wearefrank/openforms2xxllnc/commit/cc92c886052e1ce724016c422d77c6bc493d3d6d))

## 1.0.0 (2024-07-31)

### 🍕 Features

* case reference is shown in a column in Ladybug ([071a1e7](https://github.com/wearefrank/openforms2xxllnc/commit/071a1e7ebc00994dd556debc4c095e829e1e2d31))

### 🐛 Bug Fixes

* missing unwrap of objects api in WorkflowSelector adapter ([0e385e7](https://github.com/wearefrank/openforms2xxllnc/commit/0e385e7090929c1e0c41da6cb9a2cfe448eb947e))

### 🧑‍💻 Code Refactoring

* copy and integrate reusable components from openforms2bpel ([10ef7ac](https://github.com/wearefrank/openforms2xxllnc/commit/10ef7ac0789d7d6457e726d41de2c7afe7056fdf))
* move properties to the individual configuration DeploymentSpecific files where possible ([08de27e](https://github.com/wearefrank/openforms2xxllnc/commit/08de27e30b4ca90bb07360c97dc3790ad60e6d81))

### ✅ Tests

* modernize docker-compose dev environment including docker watch implementation ([d9cd28b](https://github.com/wearefrank/openforms2xxllnc/commit/d9cd28b290beff46799a24384fd6ad60be89112f))

### 🤖 Build System

* configure default credentials.properties with dummies in dockerfile so that adapters can start ([76496f4](https://github.com/wearefrank/openforms2xxllnc/commit/76496f46f5960b41a7e7e371fd666b31e698473c))

### 🔁 Continuous Integration

* use pat for analyze commits step during release ([14b29dd](https://github.com/wearefrank/openforms2xxllnc/commit/14b29ddfd80fad51545abd7b17ba385827ab94f7))
