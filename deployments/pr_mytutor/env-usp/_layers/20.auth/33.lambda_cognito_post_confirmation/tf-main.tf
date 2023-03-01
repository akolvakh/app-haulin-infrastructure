#--------------------------------------------------------------
# Post Confirmation Kafka
#--------------------------------------------------------------
module "lambda_source_code" {
  source = "./lambda/python"
}

data "archive_file" "lambda_layer_package" {
  type        = "zip"
  source_dir  = "../_layers/20.auth/33.lambda_cognito_post_confirmation/lambda/python"
  output_path = "${path.root}/build/${var.lambda_name}/lambda_request.zip"
}

module "lambda" {
  source                  = "../../../../../../libft/generic-modules/lambda-lambda"
  function_name           = "${module.label.id}_${var.lambda_name}"
  function_role_path      = "/service-role/"
  function_handler        = "lambda_request.lambda_handler"
  function_runtime        = "python3.7" //"python3.9"
  function_archive        = data.archive_file.lambda_layer_package.output_path
  function_sha256         = filebase64sha256(data.archive_file.lambda_layer_package.output_path)
  function_timeout        = 60
  tracing_mode            = "PassThrough"
  create_layer            = false
  lambda_at_edge          = false
  create_role             = false
  lambda_role             = aws_iam_role.role.arn
  #TODO
  #restrict access only to subnets for db
  vpc_security_group_ids  = [ var.outputs_sg_sg_rds_lambda_id ]
  vpc_subnet_ids          = var.outputs_vpc_private_subnets
  environment_variables = {
    "SECRET_NAME" = aws_secretsmanager_secret.this.name
    "REGION"      = var.label["Region"]
    "MARKET"      = var.market
  }
}