output "alb_id" {
  value       = aws_lb.lb.id
  description = " The ID of the load balancer "
}
output "alb_arn" {
  value       = aws_lb.lb.arn
  description = " The ARN of the load balancer "
}
output "alb_dns_name" {
  value       = aws_lb.lb.dns_name
  description = "The DNS name of the load balancer"
}
output "alb_hosted_zone_id" {
  value       = aws_lb.lb.zone_id
  description = "hosted zone ID of the load balancer (to be used in a Route 53 Alias record)"
}

output "alb_security_groups" {
  value       = var.alb_security_groups
  description = "security groups assigned to the ALB"
}
output "alb_backends_api_name_2_tgt_arn" {
  value = zipmap(var.backends_api, aws_lb_target_group.api_tgt.*.arn)
  //value="SAMPLE {'auth' = 'arn:aws:elasticloadbalancing:eu-west-1:111111111111:targetgroup/target-group/auth'}"
  description = "map of path_prefix=>target_group_arn. To be used for deployment. Lookup target grp to attach your ECS service to, via terraform remote_state"
}
output "alb_backends_web_name_2_tgt_arn" {
  value = zipmap(var.backends_web, aws_lb_target_group.web_tgt.*.arn)
  //value="SAMPLE {'/mobileUI' = 'arn:aws:elasticloadbalancing:eu-west-1:111111111111:targetgroup/target-group/mobileUI'}"
  description = "map of path_prefix=>target_group_arn. To be used for deployment. Lookup target grp to attach your ECS service to, via terraform remote_state"
}
