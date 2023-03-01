output "vpn_proxy_eips" {
  description = "Static EIPs of VPN proxy, for phoenix VPN only"
  value       = aws_eip.nlb.*.public_ip
}
output "vpn_proxy_nlb_tgt_grp_arn" {
  value = aws_lb_target_group.ip2alb.arn
}
