#------------------------------------------------------------------------------
# General
#------------------------------------------------------------------------------
resource "random_string" "suffix" {
  length  = 8
  special = false
}

locals {
  enabled                           = var.enabled
  zone_name                         = var.zone_name == "" ? "${var.domain_name}-" : var.zone_name
  process_domain_validation_options = local.enabled && var.process_domain_validation_options && var.validation_method == "DNS"
  domain_validation_options_set     = local.process_domain_validation_options ? aws_acm_certificate.cert.0.domain_validation_options : toset([])
}

#------------------------------------------------------------------------------
# Certificate manager
#------------------------------------------------------------------------------
// Creating an amazon issued certificate
resource "aws_acm_certificate" "cert" {
  count = local.enabled ? 1 : 0

  domain_name               = var.enabled ? var.domain_name : null
  validation_method         = var.enabled ? var.validation_method : null // "DNS"
  subject_alternative_names = var.enabled ? var.subject_alternative_names : null

  options {
    certificate_transparency_logging_preference = var.certificate_transparency_logging_preference
  }

  tags = {
    Name        = "${var.app}-${var.env}-certificate-manager-${random_string.suffix.result}-"
    Terraform   = true
    App         = var.app
    Environment = "${var.app}-${var.env}"
  }

  lifecycle {
    create_before_destroy = true
  }

}

// Importing an existing certificate
resource "aws_acm_certificate" "import" {
  count = var.importing_enabled ? 1 : 0

  private_key       = var.importing_enabled ? var.private_key : null
  certificate_body  = var.importing_enabled ? var.certificate_body : null
  certificate_chain = var.importing_enabled ? var.certificate_chain : null

  tags = {
    Name        = "${var.app}-${var.env}-certificate-manager-${random_string.suffix.result}-"
    Terraform   = true
    App         = var.app
    Environment = "${var.app}-${var.env}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

// Creating a private CA issued certificate
resource "aws_acm_certificate" "private" {
  count = var.private_enabled ? 1 : 0

  domain_name               = var.private_enabled ? var.private_domain_name : null
  certificate_authority_arn = var.private_enabled ? var.private_certificate_authority_arn : null
  subject_alternative_names = var.private_enabled ? var.private_subject_alternative_names : null

  tags = {
    Name        = "${var.app}-${var.env}-certificate-manager-${random_string.suffix.result}-"
    Terraform   = true
    App         = var.app
    Environment = "${var.app}-${var.env}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

#------------------------------------------------------------------------------
# Route53 record
#------------------------------------------------------------------------------
data "aws_route53_zone" "default" {
  count        = local.process_domain_validation_options ? 1 : 0
  name         = local.zone_name
  private_zone = false
}

resource "aws_route53_record" "default" {
  for_each = {
    for dvo in local.domain_validation_options_set : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  allow_overwrite = true
  zone_id         = join("", data.aws_route53_zone.default.*.zone_id)
  ttl             = var.ttl
  name            = each.value.name
  type            = each.value.type
  records         = [each.value.record]
}

#------------------------------------------------------------------------------
# Certificate manager validation
#------------------------------------------------------------------------------
resource "aws_acm_certificate_validation" "validator" {
  count                   = local.process_domain_validation_options && var.wait_for_certificate_issued ? 1 : 0
  certificate_arn         = var.private_enabled ? join("", aws_acm_certificate.private.*.arn) : join("", aws_acm_certificate.cert.*.arn)
  validation_record_fqdns = [for record in aws_route53_record.default : record.fqdn]
}
