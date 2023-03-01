output "lambda_arn" {
  value       = aws_lambda_function.lambda.arn
  description = "arn of the lambda being created"
}
output "lambda_function_name" {
  value       = aws_lambda_function.lambda.function_name
  description = "AWS's function_name of the lambda being created"
}

output "lambda_qualified_arn" {
  value       = aws_lambda_function.lambda.qualified_arn
  description = "ARN identifying your Lambda Function Version (if versioning is enabled via publish = true)"
}
