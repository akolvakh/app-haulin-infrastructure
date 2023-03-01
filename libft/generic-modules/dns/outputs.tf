output "zone_id" {
  value = aws_route53_zone.zone.zone_id
}
output "domain" {
  value = aws_route53_zone.zone.name
}