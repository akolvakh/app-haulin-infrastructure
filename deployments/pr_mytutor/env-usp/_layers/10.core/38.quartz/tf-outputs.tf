#--------------------------------------------------------------
# DB
#--------------------------------------------------------------
output "db_quartz_entrypoint" {
  value       = module.rds_aurora.db_cluster_endpoint
  description = "db url to connect to. Sample: product-dev-cluster-new.cluster-c8l0ihekb0ck.us-east-1.rds.amazonaws.com"
}

output "db_cluster_arn" {
  value       = module.rds_aurora.db_cluster_arn
  description = "ARN od RDS being created"
}

#--------------------------------------------------------------
# Bastion
#--------------------------------------------------------------
output "bastion_ip" {
  value = module.bastion.ec2_instance.public_ip
}


#--------------------------------------------------------------
# Security Groups
#--------------------------------------------------------------
output "sg_bastion_id" {
  value       = module.bastion_sg.sg_id
  description = "security group of Bastion for RDS"
}

output "sg_default_db_id" {
  value       = aws_security_group.sg.id
  description = "security group of default DB"
}