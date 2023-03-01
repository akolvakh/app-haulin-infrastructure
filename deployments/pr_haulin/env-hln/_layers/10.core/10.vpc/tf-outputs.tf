#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------
output "vpc_id" {
  value       = module.main_vpc.vpc_id
  description = "id of VPC created"
}
output "vpc_cidr_block" {
  value       = module.main_vpc.vpc_cidr_block
  description = "The VPC IP range in CIDR format."
}
output "vpc_nat_eips_cidr" {
  value       = module.main_vpc.nat_eips_cidr
  description = "NAT EIPS - internet visible source ips for egress traffic, in cidr format"
}

#--------------------------------------------------------------
# Subnets
#--------------------------------------------------------------
output "public_subnets" {
  value       = module.main_vpc.public_subnets
  description = "A list of public subnet IDs."
}

output "private_subnets" {
  value       = module.main_vpc.private_subnets
  description = "A list of private subnet IDs."
}

#--------------------------------------------------------------
# Route53
#--------------------------------------------------------------
output "r53_private_zone_id" {
  value       = module.main_vpc.r53_private_zone_id
  description = "The Hosted Zone ID. This can be referenced by zone records"
}

output "r53_private_hosted_domain_zone_name" {
  value       = module.main_vpc.private_hosted_domain_zone_name
  description = "The Hosted Zone domain name"
}