#--------------------------------------------------------------
# Cache
#--------------------------------------------------------------
output "cache_entrypoint" {
  value       = module.cache.cache_entrypoint
  description = "Redis cache entry point"
}