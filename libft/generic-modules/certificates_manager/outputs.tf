#------------------------------------------------------------------------------
# Certificate manager variables
#------------------------------------------------------------------------------
output "cert_id" {
  description = "The ARN of the certificate."
  value       = var.private_enabled ? aws_acm_certificate.private.*.id : aws_acm_certificate.cert.*.id
}

output "cert_arn" {
  description = "The ARN of the certificate."
  value       = var.private_enabled ? aws_acm_certificate.private.*.arn : aws_acm_certificate.cert.*.arn
}

output "cert_domain_name" {
  description = "The domain name for which the certificate is issued."
  value       = var.private_enabled ? aws_acm_certificate.private.*.domain_name : aws_acm_certificate.cert.*.domain_name
}


output "cert_domain_validation_options" {
  description = "Set of domain validation objects which can be used to complete certificate validation. Can have more than one element, e.g. if SANs are defined. Only set if DNS-validation was used."
  value       = var.private_enabled ? aws_acm_certificate.private.*.domain_validation_options : aws_acm_certificate.cert.*.domain_validation_options
}

output "cert_status" {
  description = "Status of the certificate."
  value       = var.private_enabled ? aws_acm_certificate.private.*.status : aws_acm_certificate.cert.*.status
}

output "cert_validation_emails" {
  description = "A list of addresses that received a validation E-Mail. Only set if EMAIL-validation was used."
  value       = var.private_enabled ? aws_acm_certificate.private.*.validation_emails : aws_acm_certificate.cert.*.validation_emails
}

#------------------------------------------------------------------------------
# Certificate manager validation
#------------------------------------------------------------------------------
output "cmv_id" {
  description = "The time at which the certificate was issued."
  value       = aws_acm_certificate_validation.example.*.id
}
