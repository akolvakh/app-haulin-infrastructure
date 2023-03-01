#------------------------------------------------------------------------------
# VPC
#------------------------------------------------------------------------------
output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC."
  value       = aws_vpc.main.cidr_block
}

#------------------------------------------------------------------------------
# AWS Internet Gateway
#------------------------------------------------------------------------------
output "internet_gateway_id" {
  description = "ID of the generated Internet Gateway."
  value       = aws_internet_gateway.gw.id
}

output "rt_id" {
  description = "ID of the route table."
  value       = aws_route_table.rt.id
}

output "private_rt_id" {
  description = "The private route table ID."
  value       = aws_route_table.rt_private.id
}