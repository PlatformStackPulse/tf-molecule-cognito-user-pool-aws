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

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
