
resource "aws_lambda_function" "lambda" {
  function_name    = var.function_name
  filename         = var.function_archive
  handler          = var.function_handler
  role             = var.create_role ? aws_iam_role.lambda[0].arn : var.lambda_role
  publish          = var.lambda_at_edge
  runtime          = var.function_runtime
  source_code_hash = var.function_sha256
  layers           = aws_lambda_layer_version.lambda_layer[*].arn
  timeout          = var.function_timeout

  dynamic "tracing_config" {
    for_each = var.tracing_mode == null ? [] : [true]
    content {
      mode = var.tracing_mode
    }
  }

  dynamic "vpc_config" {
    for_each = var.vpc_subnet_ids != null && var.vpc_security_group_ids != null ? [true] : []
    content {
      security_group_ids = var.vpc_security_group_ids
      subnet_ids         = var.vpc_subnet_ids
    }
  }

  dynamic "environment" {
    for_each = length(keys(var.environment_variables)) == 0 ? [] : [true]
    content {
      variables = var.environment_variables
    }
  }

  dynamic "file_system_config" {
    for_each = var.file_system_arn != null && var.file_system_local_mount_path != null ? [true] : []
    content {
      local_mount_path = var.file_system_local_mount_path
      arn              = var.file_system_arn
    }
  }
}

