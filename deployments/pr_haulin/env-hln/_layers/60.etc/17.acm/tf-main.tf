#data "aws_route53_zone" "r53zone" {
#  name         = "example.com"
#  private_zone = false
#}

#--------------------------------------------------------------
# Certificates
#--------------------------------------------------------------
resource "aws_acm_certificate" "cloudfront" {
  domain_name               = var.acm_cloudfront
  # subject_alternative_names = ["*.${var.environment}.ajuma.local"] || ["*.${var.label["Environment}.${var.external_dns_domain}"] //optional || ["api.${var.label["Environment}.${var.external_dns_domain}"] //optional || ["${module.label.tags["Product"]}.${var.label["Environment}.${var.external_dns_domain}"] //optional || ["${var.label["Environment"]}.${var.external_dns_domain}"] //optional
  # certificate_authority_arn = var.certificate_authority_arn
  validation_method = "DNS" //"EMAIL" 
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "loadbalancer" {
  domain_name               = var.acm_loadbalancer
  # subject_alternative_names = 
  # certificate_authority_arn = var.certificate_authority_arn
  validation_method = "DNS" //EMAIL
  lifecycle {
    create_before_destroy = true
  }
}

#--------------------------------------------------------------
# Cloudfront ACM Validation
#--------------------------------------------------------------
#resource "aws_route53_record" "cloudfront" {
#  for_each = {
#  for dvo in aws_acm_certificate.cloudfront.domain_validation_options : dvo.domain_name => {
#    name   = dvo.resource_record_name
#    record = dvo.resource_record_value
#    type   = dvo.resource_record_type
#  }
#  }
#
#  allow_overwrite = true
#  name            = each.value.name
#  records         = [each.value.record]
#  ttl             = 60
#  type            = each.value.type
#  zone_id         = data.aws_route53_zone.r53zone.zone_id
#}
#
#resource "aws_acm_certificate_validation" "cloudfront" {
#  certificate_arn         = aws_acm_certificate.cloudfront.arn
#  validation_record_fqdns = [for record in aws_route53_record.cloudfront : record.fqdn]
#}
#
##--------------------------------------------------------------
## Loadbalancer ACM Validation
##--------------------------------------------------------------
#resource "aws_route53_record" "loadbalancer" {
#  for_each = {
#  for dvo in aws_acm_certificate.loadbalancer.domain_validation_options : dvo.domain_name => {
#    name   = dvo.resource_record_name
#    record = dvo.resource_record_value
#    type   = dvo.resource_record_type
#  }
#  }
#
#  allow_overwrite = true
#  name            = each.value.name
#  records         = [each.value.record]
#  ttl             = 60
#  type            = each.value.type
#  zone_id         = data.aws_route53_zone.r53zone.zone_id
#}
#
#resource "aws_acm_certificate_validation" "loadbalancer" {
#  certificate_arn         = aws_acm_certificate.loadbalancer.arn
#  validation_record_fqdns = [for record in aws_route53_record.loadbalancer : record.fqdn]
#}