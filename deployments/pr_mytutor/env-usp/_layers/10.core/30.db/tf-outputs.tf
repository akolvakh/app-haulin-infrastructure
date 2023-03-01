#--------------------------------------------------------------
# DB
#--------------------------------------------------------------
output "db_main_entrypoint" {
  value       = module.rds_aurora.db_cluster_endpoint
  description = "db url to connect to. Sample: product-dev-cluster-new.cluster-c8l0ihekb0ck.us-east-1.rds.amazonaws.com"
}

output "db_cluster_arn" {
  value       = module.rds_aurora.db_cluster_arn
  description = "ARN od RDS being created"
}