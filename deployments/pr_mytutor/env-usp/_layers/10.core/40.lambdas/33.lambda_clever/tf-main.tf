#--------------------------------------------------------------
# Post Authentication
#--------------------------------------------------------------
module "lambda_source_code" {
  source = "./lambda/js"
}

data "archive_file" "lambda_layer_package" {
  type        = "zip"
  source_dir  = "../_layers/10.core/40.lambdas/33.lambda_clever/lambda/js"
  output_path = "${path.root}/build/${var.lambda_name}/lambda_request.zip"
}

module "lambda" {
  source                = "../../../../../../../libft/generic-modules/lambda-lambda"
  function_name         = "${module.label.id}_${var.lambda_name}"
  function_role_path    = "/service-role/"
  function_handler      = "index.handler"
  function_runtime      = "nodejs16.x"
  function_archive      = data.archive_file.lambda_layer_package.output_path
  function_sha256       = filebase64sha256(data.archive_file.lambda_layer_package.output_path)
  function_timeout      = 60
  tracing_mode          = "PassThrough"
  create_layer          = false
  lambda_at_edge        = false
  create_role           = false
  lambda_role           = aws_iam_role.role.arn
  environment_variables = {
    "URL" = var.clever_url
  }
}