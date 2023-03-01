#------------------------------------------------------------------------------
# AWS ECS Task Definition
#------------------------------------------------------------------------------
output "td_arn" {
  description = "ARN of the ecs task definition."
  value       = aws_ecs_task_definition.main.arn
}

output "td_revision" {
  description = "The revision of the task in a particular family."
  value       = aws_ecs_task_definition.main.revision
}
