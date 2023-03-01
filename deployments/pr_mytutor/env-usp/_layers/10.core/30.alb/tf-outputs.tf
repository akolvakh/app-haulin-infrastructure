#--------------------------------------------------------------
# ALB Public App
#--------------------------------------------------------------
output "alb_public_app_dns_name" {
  value = module.alb_public_app.alb_dns_name
}

#output "alb_public_app_backends_api_name_2_tgt_grp_map" {
#  value = module.alb_public_app.alb_backends_api_name_2_tgt_arn
#}

#output "alb_public_app_backends_web_name_2_tgt_grp_map" {
#  value = module.alb_public_app.alb_backends_web_name_2_tgt_arn
#}

output "alb_public_app_security_groups" {
  value       = module.alb_public_app.alb_security_groups
  description = "security groups assigned to the public ALB"
}

#output "alb_public_app_backends_api_gateway" {
#  value = module.alb_public_app.alb_backends_api_gateway_arn
#}

#--------------------------------------------------------------
# ALB Private
#--------------------------------------------------------------
# output "alb_alb_private_dns_name" {
#   value = module.alb_private.alb_dns_name
# }

# output "alb_apl_private_hosted_zone_id" {
#   value = module.alb_private.alb_hosted_zone_id
# }

# output "alb_private_backends_api_name_2_tgt_grp_map" {
#   value = module.alb_private.alb_backends_api_name_2_tgt_arn
# }

# output "alb_private_security_groups" {
#   value       = module.alb_private.alb_security_groups
#   description = "security groups assigned to the internal ALB"
# }

#--------------------------------------------------------------
# NLB for static ips
#--------------------------------------------------------------
#output "vpn_proxy_eips" {
#  description = "Static EIPs of VPN proxy, for product VPN only"
#  value       = data.terraform_remote_state.static_ips.outputs.env_entrypoint_static_ips_cidr
#}

# output "vpn_proxy_nlb_tgt_grp_arn" {
#   value = module.alb_nlb_vpn_proxy.vpn_proxy_nlb_tgt_grp_arn
# }

output "module_label_tags" {
  value = module.label.tags
}

output "alb_apl_private_hosted_zone_id" {
  value = module.alb_public_app.alb_hosted_zone_id
}

output "aws_lb_listener_http" {
  value = module.alb_public_app.aws_lb_listener_http
}

output "aws_lb_listener_https" {
  value = module.alb_public_app.aws_lb_listener_https
}