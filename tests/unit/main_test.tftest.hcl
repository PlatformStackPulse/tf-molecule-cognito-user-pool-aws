# Unit tests — plan-only, mock provider (no real AWS).
# Run: terraform init -backend=false && terraform test -test-directory=tests/unit
mock_provider "aws" {}

variables {
  namespace = "eg"
  stage     = "test"
  name      = "thing"
  pool_name = "eg-test-pool"
}

run "creates_user_pool" {
  command = plan

  assert {
    condition     = aws_cognito_user_pool.this.name == "eg-test-pool"
    error_message = "user pool name should equal var.pool_name"
  }

  assert {
    condition     = contains(aws_cognito_user_pool.this.username_attributes, "email")
    error_message = "user pool should use email as a username attribute"
  }
}

run "social_idps_disabled_without_client_ids" {
  command = plan

  # No *_client_id supplied (the default) → every social identity provider is count = 0.
  assert {
    condition     = length(aws_cognito_identity_provider.google) == 0
    error_message = "google IdP must not be created without google_client_id"
  }
  assert {
    condition = (length(aws_cognito_identity_provider.facebook) == 0 &&
      length(aws_cognito_identity_provider.apple) == 0 &&
    length(aws_cognito_identity_provider.x) == 0)
    error_message = "facebook/apple/x IdPs must not be created without their client ids"
  }
}
