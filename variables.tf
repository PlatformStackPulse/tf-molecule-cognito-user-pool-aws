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
