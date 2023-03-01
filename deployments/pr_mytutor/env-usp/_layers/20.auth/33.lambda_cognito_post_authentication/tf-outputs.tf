#--------------------------------------------------------------
#
#--------------------------------------------------------------
output "function_name" {
  value = module.lambda.lambda_function_name
}

output "arn" {
  value = module.lambda.lambda_function_arn
}