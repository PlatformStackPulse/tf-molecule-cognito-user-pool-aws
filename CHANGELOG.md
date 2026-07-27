# Changelog


<a name="v1.0.1-fix-ci-docs-and-random-provider.18"></a>
## [v1.0.1-fix-ci-docs-and-random-provider.18](https://github.com/PlatformStackPulse/Terraform-module-base-template/compare/v1.0.0...v1.0.1-fix-ci-docs-and-random-provider.18) (2026-07-27)

### Bug Fixes

- use permanent password instead of temporary for internal users ([b84ac26](https://github.com/PlatformStackPulse/Terraform-module-base-template/commit/b84ac26a0ec1ff596bf3b30931d50b600aa9c93e))
- enforce password policy compliance in random_password ([5475747](https://github.com/PlatformStackPulse/Terraform-module-base-template/commit/5475747ea0b379aa47e496a3d79b2b7ca2bdc096))
- rewrite with inline resources (fix atom interface mismatch) ([3e2e66b](https://github.com/PlatformStackPulse/Terraform-module-base-template/commit/3e2e66bae505dfd1d74aab9e689feba021ffcd49))
- remove duplicate tags variable (already in context.tf) ([92cc1fc](https://github.com/PlatformStackPulse/Terraform-module-base-template/commit/92cc1fc937a42e578d2b7c50a5351ab051bf6c5a))
- **ci:** declare random provider and regenerate README ([16ae441](https://github.com/PlatformStackPulse/Terraform-module-base-template/commit/16ae4417cc39e797adfb0828e1d33afa3f08e70e))

### Documentation

- use provider version constraints in README (match CI, no lock) ([0268a7b](https://github.com/PlatformStackPulse/Terraform-module-base-template/commit/0268a7bc89fd573e7604d7aa3f29d2e077e717c6))
- **changelog:** update CHANGELOG.md [skip ci] ([f27e08e](https://github.com/PlatformStackPulse/Terraform-module-base-template/commit/f27e08ef6f758c1a2fd4d71854123d0ca0f142f5))

### Features

- optional Hosted-UI domain (aws_cognito_user_pool_domain) ([257e1e0](https://github.com/PlatformStackPulse/Terraform-module-base-template/commit/257e1e0f6344fa067365090a55a0b496891b5693))
- add Facebook, Apple, and generic-OIDC (X) identity providers ([#1](https://github.com/PlatformStackPulse/Terraform-module-base-template/issues/1)) ([df23741](https://github.com/PlatformStackPulse/Terraform-module-base-template/commit/df237419035ab995e9803da5ac6332d9e3ef089e))
- add user_groups and internal_users support ([bea58df](https://github.com/PlatformStackPulse/Terraform-module-base-template/commit/bea58df88daf639930d3ba5c2bf9bf45f007c23a))
- add custom:role schema attribute and ADMIN_USER_PASSWORD_AUTH flow ([a1d1f4b](https://github.com/PlatformStackPulse/Terraform-module-base-template/commit/a1d1f4b0586f64e19308ebbb53b086764982bf12))
- add Cognito User Pool molecule ([299d2c9](https://github.com/PlatformStackPulse/Terraform-module-base-template/commit/299d2c99a35f2ceb7e538499b870416d7d536334))


<a name="v1.0.0"></a>
## v1.0.0 (2026-05-27)

### Documentation

- **changelog:** update CHANGELOG.md [skip ci] ([a357371](https://github.com/PlatformStackPulse/Terraform-module-base-template/commit/a357371727ff6ce65e61f29ff5b2cce545fabb8d))

