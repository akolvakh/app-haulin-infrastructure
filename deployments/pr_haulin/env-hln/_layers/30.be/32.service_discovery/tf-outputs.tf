output "service_discovery_private_dns_namespace_id" {
    value = aws_service_discovery_private_dns_namespace.this.id
}

output "service_discovery_private_dns_name" {
    value = aws_service_discovery_private_dns_namespace.this.name
}