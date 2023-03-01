output "app_id" {
  value = aws_appconfig_application.this.id
}

output "app_arn" {
  value = aws_appconfig_application.this.arn
}

output "app_name" {
  value = aws_appconfig_application.this.name
}

output "configuration_profile_id" {
  value = aws_appconfig_configuration_profile.this.configuration_profile_id
}

output "configuration_profile_arn" {
  value = aws_appconfig_configuration_profile.this.arn
}

output "configuration_profile_name" {
  value = aws_appconfig_configuration_profile.this.name
}

output "hosted_configuration_version_arn" {
  value = aws_appconfig_hosted_configuration_version.this.arn
}

output "hosted_configuration_version_id" {
  value = aws_appconfig_hosted_configuration_version.this.id
}

output "appconfig_environment_arn" {
  value = aws_appconfig_environment.this.arn
}

output "appconfig_environment_id" {
  value = aws_appconfig_environment.this.id
}

output "appconfig_environment_name" {
  value = aws_appconfig_environment.this.name
}

output "appconfig_deployment_strategy_arn" {
  value = aws_appconfig_deployment_strategy.this.arn
}

output "appconfig_deployment_strategy_id" {
  value = aws_appconfig_deployment_strategy.this.id
}

output "appconfig_deployment_strategy_name" {
  value = aws_appconfig_deployment_strategy.this.name
}

output "appconfig_deployment_arn" {
  value = aws_appconfig_deployment.this.arn
}

output "appconfig_deployment_id" {
  value = aws_appconfig_deployment.this.id
}