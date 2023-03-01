#--------------------------------------------------------------
# SGs TURNED ON
#--------------------------------------------------------------
output "sg_bastion_id" {
  value       = module.bastion_sg.sg_id
  description = "security group of Bastion for RDS"
}

#output "sg_default_db_id" {
#  value       = module.db_default_sg.sg_id
#  description = "security group of default DB"
#}

output "sg_default_db_id" {
  value       = aws_security_group.sg.id
  description = "security group of default DB"
}

#output "sg_cache_id" {
#  value       = module.elasticache_sg.sg_id
#  description = "security group of APP/Admin Cache"
#}

output "sg_cache_id" {
  value       = aws_security_group.elasticache_sg.id
  description = "security group of APP/Admin Cache"
}

output "sg_alb_public_app_id" {
  value       = module.alb_public_app_sg.sg_id
  description = "security group of Main APP LB"
}

#output "sg_ecs_service_names_2_sg_id_map" {
#  value       = zipmap(module.shared_top_level_config_ecs.service_names["${module.label.tags["Environment"]}"], module.ecs_per_service_sg.*.sg_id)
#  description = "map ecsServieName=>SecurityGroupID"
#}

output "sg_kafka_id" {
  value       = module.kafka_sg.sg_id
  description = "security group of Kafka."
}

output "sg_rds_lambda_id" {
  value       = module.rds_lambda_sg.sg_id
  description = "security group of Kafka."
}

#--------------------------------------------------------------
# SGs TURNED OFF
#--------------------------------------------------------------
# output "sg_alb_internal_id" {
#   value       = module.alb_internal_sg.sg_id
#   description = "security group of Internal LB"
# }

# output "sg_autodeploy_id" {
#   value       = module.autodeploy_sg.sg_id
#   description = "security group of Autodeploy(for connect ot RDS/db migration run)"
# }

# output "sg_alb_public_admin_id" {
#   value       = module.alb_public_admin_sg.sg_id
#   description = "security group of Admin LB"
# }

# output "sg_default_lambda_id" {
#   value       = module.lambda_internal_sg.sg_id
#   description = "security group of default Lambda Internal"
# }
