#------------------------------------------------------------------------------
# LB target group
#------------------------------------------------------------------------------
output "target_group_id" {
  description = "The ARN of the Target Group (matches arn)."
  value       = aws_lb_target_group.main.id
}

output "target_group_arn" {
  description = "The ARN of the Target Group (matches id)."
  value       = aws_lb_target_group.main.arn
}

output "target_group_arn_suffix" {
  description = "The ARN suffix for use with CloudWatch Metrics."
  value       = aws_lb_target_group.main.arn_suffix
}

output "target_group_name" {
  description = "The name of the Target Group."
  value       = aws_lb_target_group.main.name
}
