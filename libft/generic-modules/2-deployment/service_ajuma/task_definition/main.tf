resource "aws_ecs_task_definition" "td" {
  family = "${local.name_prefix}-${var.service_name}"
  container_definitions = templatefile(var.container_definition_template_path, merge(var.container_definition_params, {
    aws_region       = var.aws_region
    aws_account      = data.aws_caller_identity.current.account_id
    environment      = local.common.Environment
    product          = local.common.Product
    version          = var.service_version
    name             = var.service_name
    service_2_deploy = var.service_name
  }))
  execution_role_arn = var.execution_role_arn
  task_role_arn      = var.task_role_arn
  network_mode       = "awsvpc"
  requires_compatibilities = [
  "FARGATE"]
  cpu    = var.autoscaling_config.limits_task_cpu
  memory = var.autoscaling_config.limits_task_memory
  tags = merge(
    {
      "Name" = join(
        ".",
        [
          local.common.Product,
          var.tag_role,
          local.common.Environment,
          var.service_name
        ],
      )
      "Description" = var.tag_description
    },
    local.common_tags,
    var.task_additional_tags,
  )
}
