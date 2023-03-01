output "sg_id" {
  value       = aws_security_group.sg.id
  description = "ID of created aws_security_group"
}
output "sg_arn" {
  value       = aws_security_group.sg.arn
  description = "ARN of created aws_security_group"
}