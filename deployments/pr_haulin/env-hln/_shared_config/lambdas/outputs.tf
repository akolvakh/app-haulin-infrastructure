output "lambda_names" {
  value       = ["codepipeline_slack_integration_lambda", "cloudfront_cache_headers_lambda", "cognito_presignup_lambda", "cognito_preauthorization_lambda", "cognito_post_confirmation_lambda"]
  description = "Dockerized Lambdas to prepare infra for"
}
