output "ecr_repository_url" {
  description = "URL of the ECR repository."
  value       = tostring(try(aws_ecr_repository.main[0].repository_url, null))
}

output "ecr_repository_arn" {
  description = "ARN of the ECR repository."
  value       = tostring(try(aws_ecr_repository.main[0].arn, null))
}

output "ecr_registry_id" {
  description = "ID of the ECR registry."
  value       = tostring(try(aws_ecr_repository.main[0].registry_id, null))
}
