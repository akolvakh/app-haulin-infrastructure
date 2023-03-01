#------------------------------------------------------------------------------
# ECR
#------------------------------------------------------------------------------
output "ecr_repository_url" {
  description = "URL of the ECR repository."
  value       = aws_ecr_repository.main.repository_url
}

output "ecr_repository_arn" {
  description = "ARN of the ECR repository."
  value       = aws_ecr_repository.main.arn
}

output "ecr_registry_id" {
  description = "ID of the ECR registry."
  value       = aws_ecr_repository.main.registry_id
}
