#--------------------------------------------------------------
# S3
#--------------------------------------------------------------
output "s3_bucket_arn" {
  value       = module.s3.s3_bucket_arn
  description = "The ARN of S3 bucket for remote state"
}

output "s3_bucket_name" {
  value       = module.s3.s3_bucket_id
  description = "The name of the bucket"
}

output "ecs_service_task_role" {
  value = aws_iam_role.task_role.arn
}

output "ecs_service_task_execution_role" {
  value = aws_iam_role.task_execution_role.arn
}

output "ecs_service_td" {
  value = module.task_def.task_def_id
}

output "ecs_service_ecr" {
  value = aws_ecr_repository.ecr.repository_url
}

output "ecs_service_service_name" {
  value = module.service.ecs_service_service_name
}