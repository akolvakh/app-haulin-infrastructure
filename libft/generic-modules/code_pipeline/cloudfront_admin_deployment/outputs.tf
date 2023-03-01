output "s3_artifacts_bucket" {
  description = "The bucket."
  value       = module.s3_bucket.s3_bucket_bucket
}

output "codepipelines" {
  value = aws_codepipeline.default
}