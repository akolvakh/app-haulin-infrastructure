#--------------------------------------------------------------
# Post Authentication
#--------------------------------------------------------------
module "lambda_source_code" {
  source = "./lambda/java"
}

data "archive_file" "lambda_layer_package" {
  type        = "zip"
  source_dir  = "../_layers/20.auth/33.lambda_cognito_custom_email_sender/lambda/java/output"
  output_path = "${path.root}/build/${var.lambda_name}/lambda_request.zip"
}

module "lambda" {
  source                = "../../../../../../libft/generic-modules/lambda-lambda"
  function_name         = "${module.label.id}_${var.lambda_name}"
  function_role_path    = "/service-role/"
  function_handler      = "handler.LambdaHandler" //lambda_request.Request::handleRequest 
  function_runtime      = "java11"
  function_archive      = data.archive_file.lambda_layer_package.output_path
  function_sha256       = filebase64sha256(data.archive_file.lambda_layer_package.output_path)
  function_timeout      = 60
  tracing_mode          = "PassThrough"
  create_layer          = false
  lambda_at_edge        = false
  create_role           = false
  lambda_role           = aws_iam_role.role.arn
  environment_variables = {
    "SECRET_NAME" = aws_secretsmanager_secret.this.name
    "REGION"      = var.label["Region"]
  }
  vpc_security_group_ids  = [ var.outputs_sg_sg_rds_lambda_id ]
  vpc_subnet_ids          = var.outputs_vpc_private_subnets
}