#------------------------------------------------------------------------------
# AWS Security group
#------------------------------------------------------------------------------
output "security_group_id" {
  description = "The ID of the security group."
  value       = aws_security_group.default.id
}

output "security_group_arn" {
  description = "The ARN of the security group."
  value       = aws_security_group.default.arn
}

output "security_group_name" {
  description = "The name of the security group."
  value       = aws_security_group.default.name
}

output "security_group_ingress" {
  description = "The ingress rules."
  value       = aws_security_group.default.ingress
}

output "security_group_egress" {
  description = "The egress rules."
  value       = aws_security_group.default.egress
}
