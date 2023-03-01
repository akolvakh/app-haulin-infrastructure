output "s3_bucket_id" {
  description = "The name of the bucket."
  value       = element(concat(aws_s3_bucket.bucket.*.id, [""]), 0)
}

output "s3_bucket_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = element(concat(aws_s3_bucket.bucket.*.arn, [""]), 0)
}

output "s3_bucket_bucket" {
  description = "The bucket."
  value       = element(concat(aws_s3_bucket.bucket.*.bucket, [""]), 0)
}

output "bucket_regional_domain_name" {
  description = "Bucket regional domain name."
  value       = element(concat(aws_s3_bucket.bucket.*.bucket_regional_domain_name, [""]), 0)
}

output "secpolicy_predefined_json" {
  value = data.aws_iam_policy_document.deny_insecure_transport.json
}
