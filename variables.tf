# -----------------------------------------------------------------------------
# Module-Specific Variables
# -----------------------------------------------------------------------------

variable "pool_name" {
  type        = string
  description = "Name of the Cognito User Pool"
}

variable "google_client_id" {
  type        = string
  default     = ""
  description = "Google OAuth 2.0 client ID for social login"
}

variable "google_client_secret" {
  type        = string
  default     = ""
  sensitive   = true
  description = "Google OAuth 2.0 client secret"
}

variable "facebook_client_id" {
  type        = string
  default     = ""
  description = "Facebook (Meta) app ID for social login"
}

variable "facebook_client_secret" {
  type        = string
  default     = ""
  sensitive   = true
  description = "Facebook (Meta) app secret"
}

variable "apple_services_id" {
  type        = string
  default     = ""
  description = "Apple Sign-in Services ID (acts as the client_id)"
}

variable "apple_team_id" {
  type        = string
  default     = ""
  description = "Apple Developer Team ID"
}

variable "apple_key_id" {
  type        = string
  default     = ""
  description = "Apple Sign-in private key ID"
}

variable "apple_private_key" {
  type        = string
  default     = ""
  sensitive   = true
  description = "Apple Sign-in .p8 private key contents (PEM)"
}

variable "oidc_x_client_id" {
  type        = string
  default     = ""
  description = "X (Twitter) OIDC client ID"
}

variable "oidc_x_client_secret" {
  type        = string
  default     = ""
  sensitive   = true
  description = "X (Twitter) OIDC client secret"
}

variable "oidc_x_issuer" {
  type        = string
  default     = ""
  description = "X (Twitter) OIDC issuer URL (used for OIDC discovery)"
}

variable "callback_urls" {
  type        = list(string)
  default     = []
  description = "Allowed callback URLs for the app client"
}

variable "logout_urls" {
  type        = list(string)
  default     = []
  description = "Allowed logout URLs for the app client"
}

variable "user_groups" {
  description = "Map of user groups to create (key = group name)"
  type = map(object({
    description = string
    precedence  = number
  }))
  default = {}
}

variable "internal_users" {
  description = "Map of internal users to seed (key = username prefix)"
  type = map(object({
    role = string
  }))
  default = {}
}

variable "internal_user_domain" {
  description = "Email domain for internal users (e.g., 'xpeeddating.com')"
  type        = string
  default     = "internal.local"
}
