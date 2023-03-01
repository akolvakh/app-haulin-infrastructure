output "api_gateway_sg_id" {
  value       = module.sg.sg_id
  description = "security group of api-gateway service."
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