#------------------------------------------------------------------------------
# RDS Cluster
#------------------------------------------------------------------------------
output "db_cluster_arn" {
  description = "Amazon Resource Name (ARN) of cluster."
  value       = element(concat(aws_rds_cluster.main.*.arn, [""]), 0)
}

output "db_cluster_id" {
  description = "The RDS Cluster Identifier."
  value       = element(concat(aws_rds_cluster.main.*.id, [""]), 0)
}

output "db_cluster_cluster_identifier" {
  description = "The RDS Cluster Identifier."
  value       = element(concat(aws_rds_cluster.main.*.cluster_identifier, [""]), 0)
}

output "db_cluster_cluster_resource_id" {
  description = "The RDS Cluster Resource ID."
  value       = element(concat(aws_rds_cluster.main.*.cluster_resource_id, [""]), 0)
}

output "db_cluster_cluster_members" {
  description = "List of RDS Instances that are a part of this cluster."
  value       = element(concat(aws_rds_cluster.main.*.cluster_members, [""]), 0)
}

output "db_cluster_availability_zones" {
  description = "The availability zone of the instance."
  value       = element(concat(aws_rds_cluster.main.*.availability_zones, [""]), 0)
}

output "db_cluster_backup_retention_period" {
  description = "The backup retention period."
  value       = element(concat(aws_rds_cluster.main.*.backup_retention_period, [""]), 0)
}

output "db_cluster_preferred_backup_window" {
  description = "The daily time range during which the backups happen."
  value       = element(concat(aws_rds_cluster.main.*.preferred_backup_window, [""]), 0)
}

output "db_cluster_preferred_maintenance_window" {
  description = "The maintenance window."
  value       = element(concat(aws_rds_cluster.main.*.preferred_maintenance_window, [""]), 0)
}

output "db_cluster_endpoint" {
  description = "The DNS address of the RDS instance."
  value       = element(concat(aws_rds_cluster.main.*.endpoint, [""]), 0)
}

output "db_cluster_reader_endpoint" {
  description = "A read-only endpoint for the Aurora cluster, automatically load-balanced across replicas."
  value       = element(concat(aws_rds_cluster.main.*.reader_endpoint, [""]), 0)
}

output "db_cluster_engine" {
  description = "The database engine."
  value       = element(concat(aws_rds_cluster.main.*.engine, [""]), 0)
}

output "db_cluster_engine_version" {
  description = "The database engine version."
  value       = element(concat(aws_rds_cluster.main.*.engine_version, [""]), 0)
}

output "db_cluster_database_name" {
  description = "The database name."
  value       = element(concat(aws_rds_cluster.main.*.database_name, [""]), 0)
}

output "db_cluster_port" {
  description = "The database port."
  value       = element(concat(aws_rds_cluster.main.*.port, [""]), 0)
}

output "db_cluster_master_username" {
  description = "The master username for the database."
  value       = element(concat(aws_rds_cluster.main.*.master_username, [""]), 0)
  # sensitive   = true   #ToDo
}
//@TBD should never exits here. passwords only live in secrets manager
output "db_cluster_master_password" {
  description = "The master password."
  value       = element(concat(aws_rds_cluster.main.*.master_password, [""]), 0)
  # sensitive   = true   #ToDo
}

output "db_cluster_storage_encrypted" {
  description = "Specifies whether the DB cluster is encrypted."
  value       = element(concat(aws_rds_cluster.main.*.storage_encrypted, [""]), 0)
}

output "db_cluster_replication_source_identifier" {
  description = "ARN of the source DB cluster or DB instance if this DB cluster is created as a Read Replica."
  value       = element(concat(aws_rds_cluster.main.*.replication_source_identifier, [""]), 0)
}

output "db_cluster_hosted_zone_id" {
  description = "The Route53 Hosted Zone ID of the endpoint."
  value       = element(concat(aws_rds_cluster.main.*.hosted_zone_id, [""]), 0)
}

output "db_name" {
  description = "DB name."
  value       = element(concat(aws_rds_cluster.main.*.database_name, [""]), 0)
}

output "db_sg_id" {
  description = "DB security group id."
  value       = element(concat(aws_rds_cluster.main.*.vpc_security_group_ids, [""]), 0)
}
