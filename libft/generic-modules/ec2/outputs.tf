#------------------------------------------------------------------------------
# Instance
#------------------------------------------------------------------------------
output "ec2_instance" {
  description = "EC2 instance."
  value       = aws_instance.instance
}
