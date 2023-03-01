resource "aws_lambda_function" "lambda" {
  function_name = local.func_name
  image_uri     = var.image_url
  package_type  = "Image"
  publish       = var.lambda_at_edge
  role          = var.role_arn
  timeout       = var.runtime_timeout
  memory_size   = var.memory_size

  dynamic "image_config" {
    for_each = var.image_config
    content {
      command           = lookup(image_config.value, "command")
      entry_point       = lookup(image_config.value, "entry_point")
      working_directory = lookup(image_config.value, "working_directory")
    }
  }

  dynamic "environment" {
    for_each = length(keys(var.env_variables)) == 0 ? [] : [true]
    content {
      variables = var.env_variables
    }
  }

  dynamic "vpc_config" {
    for_each = var.vpc_subnet_ids != null && var.vpc_security_group_ids != null ? [true] : []
    content {
      security_group_ids = var.vpc_security_group_ids
      subnet_ids         = var.vpc_subnet_ids
    }
  }

  tags = merge(
    {
      "Name"        = local.func_name
      "Description" = var.tag_description
    },
    local.common_tags,
    var.lambda_additional_tags,
  )
  tracing_config {
    mode = "Active"
  }

}
