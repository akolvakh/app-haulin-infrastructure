#------------------------------------------------------------------------------
# Platform application
#------------------------------------------------------------------------------
output "id" {
  description = "The ARN of the SNS platform application."
  value       = aws_sns_platform_application.apns_application.id
}

output "arn" {
  description = "The ARN of the SNS platform application."
  value       = aws_sns_platform_application.apns_application.id
}
