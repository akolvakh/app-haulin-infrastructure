output "cognito_pool_id" {
  value       = aws_cognito_user_pool.pool.id
  description = "ID of cognito user pool"
}

output "cognito_pool_endpoint" {
  value       = aws_cognito_user_pool.pool.endpoint
  description = "Endpoint  of cognito user pool"
}
output "cognito_client_id" {
  value       = aws_cognito_user_pool_client.client.id
  description = "Cognito main app client ID"
}
output "cognito_pool_domain_prefix" {
  value       = aws_cognito_user_pool.pool.domain
  description = "Domain prefix of cognito user pool"
}
output "cognito_pool_arn" {
  value       = aws_cognito_user_pool.pool.arn
  description = "ARNof cognito user pool"
}

# output "aws_cognito_identity_provider_name" {
#   value       = { for k, provider_name in aws_cognito_identity_provider.saml : k => provider_name.provider_name }
#   description = "Cognito SAML provider name"
# }

