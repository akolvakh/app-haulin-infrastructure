output "nat_eips" {
  value       = aws_eip.nat.*.public_ip
  description = "A list of elastic IP addresses (not in CIDR format)."
}

output "nat_eips_cidr" {
  value       = formatlist("%s/32", aws_eip.nat.*.public_ip)
  description = "A list of elastic IP addresses in CIDR format."
}

output "private_hosted_domain_zone_id" {
  value       = aws_route53_zone.vpc_private_zone.zone_id
  description = "The private hosted zone id."
}

output "private_hosted_domain_zone_name" {
  value       = var.private_hosted_domain
  description = "The private hosted zone domain name."
}

output "private_route_table" {
  value       = aws_route_table.private_route_table.*.id
  description = "A list of private route table IDs."
}

output "public_route_table" {
  value       = aws_route_table.public_route_table.*.id
  description = "A list of public route table IDs."
}

output "public_subnets" {
  value       = aws_subnet.public_subnets.*.id
  description = "A list of public subnet IDs."
}

output "private_subnets" {
  value       = aws_subnet.private_subnets.*.id
  description = "A list of private subnet IDs."
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The VPC ID."
}

output "vpc_cidr_block" {
  value       = aws_vpc.main.cidr_block
  description = "The VPC IP range in CIDR format."
}

output "nat_ids" {
  value       = aws_nat_gateway.nat.*.id
  description = "A list of NAT gateway IDs."
}

output "r53_private_zone_id" {
  value       = aws_route53_zone.vpc_private_zone.zone_id
  description = "The Hosted Zone ID. This can be referenced by zone records"
}