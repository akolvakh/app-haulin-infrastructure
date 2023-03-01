output "cache_entrypoint" {
  value       = var.cluster_enabled ? aws_elasticache_replication_group.cluster.*.configuration_endpoint_address : aws_elasticache_replication_group.non_cluster.*.primary_endpoint_address
  description = "Redis cache entry point"
}
output "cache_redis_port" {
  value       = var.redis_port
  description = "Redis cache TCP port"
}