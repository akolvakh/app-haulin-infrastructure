#------------------------------------------------------------------------------
# Application Load Balancer
#------------------------------------------------------------------------------
output "elb_id" {
  description = "The ARN of the load balancer (matches arn)."
  value       = aws_alb.main.id
}

output "elb_arn" {
  description = "The ARN of the load balancer (matches id)."
  value       = aws_alb.main.arn
}

output "elb_arn_suffix" {
  description = "The ARN suffix for use with CloudWatch Metrics."
  value       = aws_alb.main.arn_suffix
}

output "elb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = aws_alb.main.dns_name
}

output "elb_zone_id" {
  description = "The canonical hosted zone ID of the load balancer (to be used in a Route 53 Alias record)."
  value       = aws_alb.main.zone_id
}

output "elb_subnet_mapping_outpost_id" {
  description = "ID of the Outpost containing the load balancer."
  value       = aws_alb.main.subnet_mapping.*.outpost_id
}
