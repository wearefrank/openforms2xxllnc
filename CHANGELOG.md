[![conventional commits](https://img.shields.io/badge/conventional%20commits-1.0.0-yellow.svg)](https://conventionalcommits.org) [![semantic versioning](https://img.shields.io/badge/semantic%20versioning-2.0.0-green.svg)](https://semver.org)

## [1.2.9](https://github.com/wearefrank/openforms2xxllnc/compare/v1.2.8...v1.2.9) (2025-04-01)

### 🐛 Bug Fixes

* get kvkNummer from ExtraElement instead of inn.nnpId ([#60](https://github.com/wearefrank/openforms2xxllnc/issues/60)) ([8a6c525](https://github.com/wearefrank/openforms2xxllnc/commit/8a6c525f29c2f954f5591d3301320c92a7de8dd9))

### 🤖 Build System

* **dependencies:** bump f!f version to 9.1.0-20250328.042332 ([459a327](https://github.com/wearefrank/openforms2xxllnc/commit/459a3275e590fa5117bf2270eae79cc57a6d699f))
* **dependencies:** bump the docusaurus group across 1 directory with 9 updates ([#47](https://github.com/wearefrank/openforms2xxllnc/issues/47)) ([ec27ce8](https://github.com/wearefrank/openforms2xxllnc/commit/ec27ce8df2f0b4dc1bc9594114b247e5f44cda2b))
* **dependencies:** bump the github-actions group across 1 directory with 3 updates ([#54](https://github.com/wearefrank/openforms2xxllnc/issues/54)) ([5a5a673](https://github.com/wearefrank/openforms2xxllnc/commit/5a5a673186441dc81deef9d920924291affdcda7))

## [1.2.8](https://github.com/wearefrank/openforms2xxllnc/compare/v1.2.7...v1.2.8) (2024-12-02)

### 🧑‍💻 Code Refactoring

* transactionattribute 'RequireNew' to 'Required' and remove statusValueInProcess="I" on MessageStoreListeners ([0434e85](https://github.com/wearefrank/openforms2xxllnc/commit/0434e8503e3c09fea5f8f31d04890cde45177b4d))

## [1.2.7](https://github.com/wearefrank/openforms2xxllnc/compare/v1.2.6...v1.2.7) (2024-12-02)

### 🧑‍💻 Code Refactoring

* use * instead of static namespaces in xpath expression and use objectUuid for cid ([#26](https://github.com/wearefrank/openforms2xxllnc/issues/26)) ([77cbbe6](https://github.com/wearefrank/openforms2xxllnc/commit/77cbbe6b0e9ba2d55e231a4d4940bcfa910d4762))

### 🤖 Build System

* **dependencies:** bump the docusaurus group across 1 directory with 7 updates ([#33](https://github.com/wearefrank/openforms2xxllnc/issues/33)) ([904ea18](https://github.com/wearefrank/openforms2xxllnc/commit/904ea18b8dfda900c7aed98f92391b8a19cad57b))
* **dependencies:** bump the github-actions group across 1 directory with 4 updates ([#32](https://github.com/wearefrank/openforms2xxllnc/issues/32)) ([e227be7](https://github.com/wearefrank/openforms2xxllnc/commit/e227be79b13acb4687f51337c0156d250c561bf3))

## [1.2.6](https://github.com/wearefrank/openforms2xxllnc/compare/v1.2.5...v1.2.6) (2024-10-31)

### ⏩ Reverts

* "refactor: replace static opentunnel authentication header with configurable headername with 'Authorization` as default name" ([125c1a2](https://github.com/wearefrank/openforms2xxllnc/commit/125c1a216fbb71279393bb5cb08e842561446258))

### ✅ Tests

* use relative paths to load zds schema's and wsdl's from project dir ([5b8639a](https://github.com/wearefrank/openforms2xxllnc/commit/5b8639a35c6f82fb545cda324ccb6ae501ec3855))

## [1.2.5](https://github.com/wearefrank/openforms2xxllnc/compare/v1.2.4...v1.2.5) (2024-10-29)

### 🤖 Build System

* **dependencies:** revert f!f version to v8.3.0-20240730.042429 ([5027bdd](https://github.com/wearefrank/openforms2xxllnc/commit/5027bdd476919b779fe2564f3efd8ee1c75dc255))

## [1.2.4](https://github.com/wearefrank/openforms2xxllnc/compare/v1.2.3...v1.2.4) (2024-10-29)

### 🐛 Bug Fixes

* notificaties api subscribe adapter not sending the correct message body ([ddbe5ea](https://github.com/wearefrank/openforms2xxllnc/commit/ddbe5eae7d16af8ff7e5a86a1b1a75d6fef4a695))
* notificaties api subscribe message body using wrong object_type as filter instead of objectType ([6e3a844](https://github.com/wearefrank/openforms2xxllnc/commit/6e3a8445a94106538ff2e0a2ba3ac99bfaa49b00))

### 🧑‍💻 Code Refactoring

* replace static opentunnel authentication header with configurable headername with 'Authorization` as default name ([e01c069](https://github.com/wearefrank/openforms2xxllnc/commit/e01c069996fcf9109e67d745c45440e24773ce88))

### ✅ Tests

* replace deprecated ${} variable substitution syntax with the correct ?{} syntax in test mailtemplates ([a92206a](https://github.com/wearefrank/openforms2xxllnc/commit/a92206a05509da75984c66f3a702ab93919994df))

### 🤖 Build System

* **dependencies:** bump f!f version to 9.0.0-20241026.042336 ([d8eb624](https://github.com/wearefrank/openforms2xxllnc/commit/d8eb6245b21f68950ca150b49e7528909011f2f3))
* **dependencies:** bump the github-actions group with 1 update ([e20a8c4](https://github.com/wearefrank/openforms2xxllnc/commit/e20a8c47619eeee6aa1815a359bb3b9c214fa5ab))

## [1.2.3](https://github.com/wearefrank/openforms2xxllnc/compare/v1.2.2...v1.2.3) (2024-10-25)

### 🐛 Bug Fixes

* use identificatie from genereerDocumentIdentificatie in voegZaakdocumentToe request & add dct.omschrijving to voegZaakdocumentToe request with value from property ([#23](https://github.com/wearefrank/openforms2xxllnc/issues/23)) ([b9273e9](https://github.com/wearefrank/openforms2xxllnc/commit/b9273e96d66a39edcc4a95fd64883d52785c6fd8))

## [1.2.2](https://github.com/wearefrank/openforms2xxllnc/compare/v1.2.1...v1.2.2) (2024-10-23)

### ✅ Tests

* additional e2e tests for two-way communication workflow ([#17](https://github.com/wearefrank/openforms2xxllnc/issues/17)) ([db6efaf](https://github.com/wearefrank/openforms2xxllnc/commit/db6efafb6b076955e658cd7a6f425deb205d92b3))

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
