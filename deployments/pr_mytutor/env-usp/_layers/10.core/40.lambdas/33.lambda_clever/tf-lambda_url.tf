resource "aws_lambda_function_url" "this" {
  function_name      = module.lambda.lambda_function_name
  authorization_type = "NONE"
  
  cors {
    allow_credentials = false
    allow_origins     = ["*"]
    # allow_methods     = ["*"]
    # allow_headers     = ["*", "keep-alive"]
    # expose_headers    = ["keep-alive", "date"]
    # max_age           = 86400
  }
}