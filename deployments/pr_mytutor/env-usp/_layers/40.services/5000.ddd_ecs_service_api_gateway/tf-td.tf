module "task_def" {
  source                             = "../../../../../../libft/generic-modules/deployment/service/task_definition"
  container_definition_template_path = "${path.module}/tpl/task_definitions/service.json.tpl"
  container_definition_params = {
    cache_entrypoint                          = var.outputs_cache_cache_entrypoint[0]
    cognito_user_pool                         = var.outputs_cognito_cognito_app_pool_id
    docker_registry_url                       = aws_ecr_repository.ecr.repository_url
    spring_profiles_active                    = var.spring_profiles_active
    server_base_url                           = var.server_base_url
    server_domain                             = var.server_domain
    service_name                              = var.service_name
    platform_name                             = var.platform_name
    manual                                    = false
    logging_level_or_springframework_security = "DEBUG"
    redis_port                                = 6379
    redis_cache_expiration_time               = 600
  }
  service_name         = var.service_name
  service_version      = var.service_version
  execution_role_arn   = aws_iam_role.task_execution_role.arn
  task_role_arn        = aws_iam_role.task_role.arn
  autoscaling_config   = local.autoscaling[module.label.tags["Environment"]]
  aws_region           = var.label["Region"]
  tag_description      = var.tag_description
  task_additional_tags = module.label.tags
  label                = module.label.tags
}
