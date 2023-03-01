#------------------------------------------------------------------------------
# Route53 zones
#------------------------------------------------------------------------------
output "zone_id" {
  description = "The Hosted Zone ID. This can be referenced by zone records."
  value       = var.zone_id != "" ? "" : (var.public_enabled ? join("", aws_route53_zone.public.*.zone_id) : join("", aws_route53_zone.private.*.zone_id))
}
