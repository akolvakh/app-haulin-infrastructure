output "acmpca_arn" {
  description = "Amazon Resource Name (ARN) of the certificate authority"
  value       = resource.aws_acmpca_certificate_authority_certificate.acmpca.certificate_authority_arn
}