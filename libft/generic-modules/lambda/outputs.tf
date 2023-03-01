# Lambda Function
output "lambda_function_arn" {
  description = "The ARN of the Lambda Function"
  value       = element(concat(aws_lambda_function.lambda.*.arn, [""]), 0)
}

output "lambda_function_invoke_arn" {
  description = "The Invoke ARN of the Lambda Function"
  value       = element(concat(aws_lambda_function.lambda.*.invoke_arn, [""]), 0)
}

output "lambda_function_name" {
  description = "The name of the Lambda Function"
  value       = element(concat(aws_lambda_function.lambda.*.function_name, [""]), 0)
}

output "lambda_function_qualified_arn" {
  description = "The ARN identifying your Lambda Function Version"
  value       = element(concat(aws_lambda_function.lambda.*.qualified_arn, [""]), 0)
}

output "lambda_function_version" {
  description = "Latest published version of Lambda Function"
  value       = element(concat(aws_lambda_function.lambda.*.version, [""]), 0)
}

output "lambda_role_arn" {
  description = "The ARN of the IAM role created for the Lambda Function"
  value       = element(concat(aws_iam_role.lambda.*.arn, [""]), 0)
}

output "lambda_role_name" {
  description = "The name of the IAM role created for the Lambda Function"
  value       = element(concat(aws_iam_role.lambda.*.name, [""]), 0)
}
