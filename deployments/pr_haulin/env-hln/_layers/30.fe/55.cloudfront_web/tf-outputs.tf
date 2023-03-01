#--------------------------------------------------------------
# Cloudfront
#--------------------------------------------------------------
output "s3_name" {
  description = "The name of the bucket."
  value       = module.fe.s3_bucket_id
}

output "s3_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucket_name."
  value       = module.fe.s3_bucket_arn
}

output "cloudfront_distribution_domain_name" {
  description = "The domain name corresponding to the distribution"
  value       = module.cloudfront.this_cloudfront_distribution_domain_name
}

output "cloudfront_distribution_hosted_zone_id" {
  description = "The hosted zone corresponding distribution"
  value       = module.cloudfront.this_cloudfront_distribution_hosted_zone_id
}

output "cloudfront_admin_fe_id" {
  description = "The domain name corresponding to the distribution"
  value       = module.cloudfront.this_cloudfront_distribution_id
}

output "cloudfront_admin_fe_arn" {
  description = "ARN corresponding to the distribution"
  value       = module.cloudfront.this_cloudfront_distribution_arn
}