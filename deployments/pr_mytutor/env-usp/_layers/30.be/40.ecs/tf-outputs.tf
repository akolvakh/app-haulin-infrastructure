#--------------------------------------------------------------
# ECS
#--------------------------------------------------------------
output "ecs_main_cluster_name" {
  value       = aws_ecs_cluster.main.name
  description = "name of ECS cluster"
}

output "ecs_main_cluster_arn" {
  value       = aws_ecs_cluster.main.arn
  description = "arn of ECS cluster"
}

#output "ecs_service_name_2_task_execution_role_map" {
#  value       = zipmap(module.shared_ecs_services_config.service_names["${module.label.tags["Environment"]}"], aws_iam_role.task_execution_role.*.arn)
#  description = "map of serviceName to arn of taskExecutionRole per service. Sample {'be' = 'arn:.../executionRole'}"
#}
#
#output "ecs_service_name_2_task_role_map" {
#  value       = zipmap(module.shared_ecs_services_config.service_names["${module.label.tags["Environment"]}"], aws_iam_role.task_role.*.arn)
#  description = "map of serviceName to arn of taskExecutionRole per service. Sample {'be' = 'arn:.../executionRole'}"
#}
#
#output "ecs_service_name_2_task_role_name_map" {
#  value       = zipmap(module.shared_ecs_services_config.service_names["${module.label.tags["Environment"]}"], aws_iam_role.task_role.*.name)
#  description = "map of serviceName to arn of taskExecutionRole per service. Sample {'be' = 'arn:.../executionRole'}"
#}
#
#output "ecs_service_name_2_ecr_url_map" {
#  value       = { for v in module.shared_ecs_services_config.service_names["${module.label.tags["Environment"]}"] : v => "${module.shared_accounts_config.ecr_account}.dkr.ecr.${module.shared_accounts_config.ecr_region}.amazonaws.com/${module.label.tags["Product"]}_${v}" }
#  description = "map of ecs serviceName to ECR repo URL per service. Sample {'be' = '177795352040.dkr.ecr.us-west-1.amazonaws.com/service_be'}"
#}
#
#output "ecs_ecr_urls" {
#  value = "dev" == var.environment ? aws_ecr_repository.ecr.*.repository_url : []
#}