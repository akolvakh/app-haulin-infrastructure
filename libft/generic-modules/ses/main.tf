// https://docs.aws.amazon.com/ses/latest/DeveloperGuide/mail-from.html
resource "aws_ses_email_identity" "mobile_mail_from" {
  email = (var.environment == "prod" ? local.email_production : local.email_not_production)
}
resource "aws_ses_domain_identity" "mail_domain_identity" {
  domain = var.dns_external_zone_domain
}

resource "aws_ses_domain_mail_from" "mobile_main_from" {
  domain           = aws_ses_domain_identity.mail_domain_identity.domain
  mail_from_domain = var.mail_from_domain
}
