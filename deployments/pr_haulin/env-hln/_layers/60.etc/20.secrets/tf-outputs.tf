#--------------------------------------------------------------
# Secrets
#--------------------------------------------------------------
# output "db_be_root_unpw_arn" {
#   description = "secrets holding default(legacy)DB ROOT credentials. For auto deploy only  "
#   value       = aws_secretsmanager_secret.db_be_unpw.arn
# }

# output "cognito_proxy_secret_arn" {
#   value = aws_secretsmanager_secret.cognito_proxy_secret.arn
# }

# output "cognito_proxy_secret_name" {
#   value = aws_secretsmanager_secret.cognito_proxy_secret.name
# }

output "name_db" {
  value = aws_secretsmanager_secret.db.name
}

output "rds_lambda_arn" {
  value = aws_secretsmanager_secret.rds_lambda.name
}

output "rds_lambda_name" {
  value = aws_secretsmanager_secret.rds_lambda.arn
}