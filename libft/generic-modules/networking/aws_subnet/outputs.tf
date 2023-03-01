#------------------------------------------------------------------------------
# General
#------------------------------------------------------------------------------
output "availability_zones" {
  description = "List of availability zones used by subnets."
  value       = var.subnet_availability_zones
}

#------------------------------------------------------------------------------
# AWS Subnets public
#------------------------------------------------------------------------------
output "public_subnets_ids" {
  description = "List with the Public Subnets IDs."
  value       = aws_subnet.public.*.id
}

output "public_subnets" {
  description = "List with the Public Subnets IDs."
  value       = aws_subnet.public
}

#------------------------------------------------------------------------------
# AWS Subnets private
#------------------------------------------------------------------------------
output "private_subnets_ids" {
  description = "List with the Private Subnets IDs."
  value       = aws_subnet.private.*.id
}

output "private_subnets" {
  description = "The IDs of the Private subnets."
  value       = aws_subnet.private
}
