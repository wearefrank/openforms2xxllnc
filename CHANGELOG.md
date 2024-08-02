[![conventional commits](https://img.shields.io/badge/conventional%20commits-1.0.0-yellow.svg)](https://conventionalcommits.org) [![semantic versioning](https://img.shields.io/badge/semantic%20versioning-2.0.0-green.svg)](https://semver.org)

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
