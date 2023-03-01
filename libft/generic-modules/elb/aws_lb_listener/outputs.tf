#------------------------------------------------------------------------------
# LB target group
#------------------------------------------------------------------------------
output "lb_listener_id" {
  description = "The ARN of the Target Group (matches arn)."
  value       = aws_lb_listener.http_forward.id
}

output "lb_listener_arn" {
  description = "The ARN of the Target Group (matches id)."
  value       = aws_lb_listener.http_forward.arn
}

output "aws_lb_listener_http_forward" {
  description = "AWS Lb listener http forward."
  value       = aws_lb_listener.http_forward
}
