# =============================================================================
# Cognito User Pool Molecule
# Composes: User Pool + App Client + Domain + Google Identity Provider
#           + User Groups + Internal (Seeded) Users
# =============================================================================

resource "aws_cognito_user_pool" "this" {
  name = var.pool_name

  auto_verified_attributes = ["email"]
  username_attributes      = ["email"]

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = false
    require_uppercase = true
  }

  schema {
    attribute_data_type = "String"
    name                = "email"
    required            = true
    mutable             = true

    string_attribute_constraints {
      min_length = 1
      max_length = 256
    }
  }

  schema {
    attribute_data_type      = "String"
    name                     = "role"
    required                 = false
    mutable                  = true
    developer_only_attribute = false

    string_attribute_constraints {
      min_length = 1
      max_length = 50
    }
  }

  tags = module.this.tags
}

resource "aws_cognito_user_pool_client" "this" {
  name         = "${var.pool_name}-client"
  user_pool_id = aws_cognito_user_pool.this.id

  explicit_auth_flows = [
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_ADMIN_USER_PASSWORD_AUTH",
  ]

  supported_identity_providers         = var.google_client_id != "" ? ["Google", "COGNITO"] : ["COGNITO"]
  callback_urls                        = var.callback_urls
  logout_urls                          = var.logout_urls
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["openid", "email", "profile"]
  allowed_oauth_flows_user_pool_client = true

  generate_secret = false
}

resource "aws_cognito_identity_provider" "google" {
  count = var.google_client_id != "" ? 1 : 0

  user_pool_id  = aws_cognito_user_pool.this.id
  provider_name = "Google"
  provider_type = "Google"

  provider_details = {
    client_id        = var.google_client_id
    client_secret    = var.google_client_secret
    authorize_scopes = "openid email profile"
  }

  attribute_mapping = {
    email    = "email"
    username = "sub"
  }
}

# =============================================================================
# User Groups
# =============================================================================

resource "aws_cognito_user_group" "roles" {
  for_each = var.user_groups

  name         = each.key
  user_pool_id = aws_cognito_user_pool.this.id
  description  = each.value.description
  precedence   = each.value.precedence
}

# =============================================================================
# Internal (Seeded) Users
# =============================================================================

resource "random_password" "internal_user" {
  for_each = var.internal_users

  length           = 16
  special          = true
  numeric          = true
  upper            = true
  lower            = true
  min_numeric      = 2
  min_upper        = 2
  min_special      = 1
  override_special = "!@#$%^&*"
}

resource "aws_secretsmanager_secret" "internal_user_bootstrap" {
  for_each = var.internal_users

  name = "${var.pool_name}/internal-users/${each.key}/bootstrap"
  tags = module.this.tags
}

resource "aws_secretsmanager_secret_version" "internal_user_bootstrap" {
  for_each = var.internal_users

  secret_id = aws_secretsmanager_secret.internal_user_bootstrap[each.key].id
  secret_string = jsonencode({
    username = "${each.key}@${var.internal_user_domain}"
    password = random_password.internal_user[each.key].result
    role     = each.value.role
  })
}

resource "aws_cognito_user" "internal" {
  for_each = var.internal_users

  user_pool_id = aws_cognito_user_pool.this.id
  username     = "${each.key}@${var.internal_user_domain}"

  attributes = {
    email          = "${each.key}@${var.internal_user_domain}"
    email_verified = "true"
    "custom:role"  = each.value.role
  }

  temporary_password = random_password.internal_user[each.key].result

  depends_on = [aws_cognito_user_group.roles]
}

resource "aws_cognito_user_in_group" "internal" {
  for_each = var.internal_users

  user_pool_id = aws_cognito_user_pool.this.id
  username     = aws_cognito_user.internal[each.key].username
  group_name   = each.value.role

  depends_on = [aws_cognito_user.internal, aws_cognito_user_group.roles]
}
