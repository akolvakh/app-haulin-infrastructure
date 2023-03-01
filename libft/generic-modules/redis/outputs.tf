#------------------------------------------------------------------------------
# Redis
#------------------------------------------------------------------------------
output "id" {
  description = "Redis cluster id."
  value       = var.cluster_enabled ? "" : (var.replication_enabled ? join("", aws_elasticache_replication_group.default.*.id) : join("", aws_elasticache_replication_group.cluster.*.id))
}

output "port" {
  description = "Redis port."
  value       = var.port
  sensitive   = true
}

output "tags" {
  description = "A mapping of tags to assign to the resource."
  value       = "module.labels.tags" //ToDo
}

output "redis_endpoint" {
  description = "Redis endpoint address."
  value       = var.cluster_enabled ? "" : (var.cluster_replication_enabled ? join("", aws_elasticache_replication_group.cluster.*.configuration_endpoint_address) : join("", aws_elasticache_replication_group.default.*.primary_endpoint_address))
}