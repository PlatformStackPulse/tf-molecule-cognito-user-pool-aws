output "user_pool_id" {
  description = "The ID of the Cognito User Pool"
  value       = aws_cognito_user_pool.this.id
}

output "user_pool_arn" {
  description = "The ARN of the Cognito User Pool"
  value       = aws_cognito_user_pool.this.arn
}

output "user_pool_endpoint" {
  description = "The endpoint of the Cognito User Pool"
  value       = aws_cognito_user_pool.this.endpoint
}

output "client_id" {
  description = "The ID of the Cognito User Pool app client"
  value       = aws_cognito_user_pool_client.this.id
}

output "hosted_ui_domain" {
  description = "The Cognito Hosted-UI prefix domain (empty when none is configured)."
  value       = one(aws_cognito_user_pool_domain.this[*].domain)
}
