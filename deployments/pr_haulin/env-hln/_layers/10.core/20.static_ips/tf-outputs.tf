#--------------------------------------------------------------
# Static IPs
#--------------------------------------------------------------
output "env_entrypoint_static_ips_ids" {
  description = " "
  value       = [aws_eip.nlb[0].id, aws_eip.nlb[1].id]
}

output "env_entrypoint_static_ips_cidr" {
  description = " "
  value       = [aws_eip.nlb[0].public_ip, aws_eip.nlb[1].public_ip]
}