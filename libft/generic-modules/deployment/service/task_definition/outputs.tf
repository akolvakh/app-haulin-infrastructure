output "task_def_arn" {
  value = aws_ecs_task_definition.td.arn
}

output "task_def_id" {
  value = aws_ecs_task_definition.td.id
}