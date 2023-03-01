#--------------------------------------------------------------
# R53
#--------------------------------------------------------------
resource "aws_route53_record" "loadbalancer" {
  zone_id = var.outputs_vpc_r53_private_zone_id
  name    = "red.api.${var.label["Environment"]}.${var.external_dns_domain}"
  type    = "A"

  alias {
    name                   = var.outputs_alb_alb_public_dns_name
    zone_id                = var.outputs_alb_alb_apl_private_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "cloudfront" {
  zone_id = var.outputs_vpc_r53_private_zone_id
  name    = "red.${var.label["Environment"]}.${var.external_dns_domain}"
  type    = "A"

  alias {
    evaluate_target_health = false
    name                   = var.outputs_cloudfront_domain_name
    zone_id                = var.outputs_cloudfront_hosted_zone
  }
}