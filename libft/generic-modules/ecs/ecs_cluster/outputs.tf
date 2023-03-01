#------------------------------------------------------------------------------
# ECS
#------------------------------------------------------------------------------
output "ecs_cluster_id" {
  description = "ID of the ECS Cluster."
  value       = aws_ecs_cluster.main.id
}

output "ecs_cluster_arn" {
  description = "ARN of the ECS Cluster."
  value       = aws_ecs_cluster.main.arn
}

output "this_ecs_cluster_name" {
  description = "The name of the ECS cluster."
  value       = var.ecs_name
}
