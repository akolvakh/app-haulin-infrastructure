#--------------------------------------------------------------
# Cloudfront
#--------------------------------------------------------------
output "s3_bucket_arn" {
  value       = module.this.s3_bucket_arn
  description = "The ARN of S3 bucket for remote state"
}

output "s3_bucket_name" {
  value       = module.this.s3_bucket_id
  description = "The name of the bucket"
}