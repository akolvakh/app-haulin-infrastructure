variable "dns_external_zone_domain" {
  type        = string
  description = "Externally visible DNS domain visible to user in FROM: of a message. Example phoenix.com "
  default     = null
}
variable "dns_external_zone_id" {
  type        = string
  description = "DEPECATED. Hosted zome ID for DNS domain for SMTP outgoing messages"
  default     = null
}
variable "mail_from_domain" {
  type        = string
  description = "email domain to be used in MAIL FROM: of SMTP protocol. Must match SPF/DKIM in DNS. Must be subdomain of Organiztion domain per AWS requirements. Example: mail.phoenix.com. Ref https://docs.aws.amazon.com/ses/latest/DeveloperGuide/mail-from.html"
}
variable "aws_region" {
  description = "AWS region to create SES resources in"
}
variable "environment" {
  description = "product environment to create resources in"
}

variable "cogntio_ses_sender" {}