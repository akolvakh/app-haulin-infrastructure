#--------------------------------------------------------------
# Certificates
#--------------------------------------------------------------
output "acm_cloudfront_arn" {
  description = "The ARN of the cloudfront certificate"
  value       = aws_acm_certificate.cloudfront.arn
}

output "acm_loadbalancer_arn" {
  description = "The ARN of the loadbalancer certificate"
  value       = aws_acm_certificate.loadbalancer.arn
}