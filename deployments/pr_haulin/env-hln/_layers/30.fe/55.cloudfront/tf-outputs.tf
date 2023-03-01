#--------------------------------------------------------------
# Cloudfront
#--------------------------------------------------------------
output "app_cdn_cloudfront_url" {
  value       = module.cloudfront_app_static.this_cloudfront_distribution_domain_name
  description = "The domain name corresponding to the distribution"
}

output "s3_bucket_arn" {
  value       = module.app_static.s3_bucket_arn
  description = "The ARN of S3 bucket for remote state"
}

output "app_static_bucket_name" {
  value       = module.app_static.s3_bucket_id
  description = "The name of the bucket"
}