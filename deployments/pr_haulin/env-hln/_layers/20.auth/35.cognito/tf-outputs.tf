#--------------------------------------------------------------
# App pool
#--------------------------------------------------------------
output "cognito_app_pool_id" {
  value       = module.cognito_app_user_pool.cognito_pool_id
  description = "ID of cognito user pool"
}

output "cognito_app_pool_endpoint" {
  value       = module.cognito_app_user_pool.cognito_pool_endpoint
  description = "Endpoint  of cognito user pool"
}

output "cognito_app_client_id" {
  value       = module.cognito_app_user_pool.cognito_client_id
  description = "Cognito main app client ID"
}

output "cognito_app_pool_domain_prefix" {
  value       = module.cognito_app_user_pool.cognito_pool_domain_prefix
  description = "Domain of cognito user pool"
}

output "cognito_app_pool_arn" {
  value       = module.cognito_app_user_pool.cognito_pool_arn
  description = "ARN of cognito user pool"
}