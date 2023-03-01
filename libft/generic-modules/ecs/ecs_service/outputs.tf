#------------------------------------------------------------------------------
# ECS service
#------------------------------------------------------------------------------
output "ecs_service_id" {
  description = "The Amazon Resource Name (ARN) that identifies the service."
  value       = aws_ecs_service.service.id
}

output "ecs_service_name" {
  description = "The name of the service."
  value       = aws_ecs_service.service.name
}

output "ecs_service_cluster" {
  description = "The Amazon Resource Name (ARN) of cluster which the service runs on."
  value       = aws_ecs_service.service.cluster
}

output "ecs_service_iam_role" {
  description = "The ARN of IAM role used for ELB."
  value       = aws_ecs_service.service.iam_role
}

output "ecs_service_desired_count" {
  description = "The number of instances of the task definition."
  value       = aws_ecs_service.service.desired_count
}
