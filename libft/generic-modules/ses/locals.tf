locals {
  email_production     = "${var.cogntio_ses_sender}@${var.dns_external_zone_domain}"
  email_not_production = "${var.cogntio_ses_sender}+${var.environment}@${var.dns_external_zone_domain}"
}

