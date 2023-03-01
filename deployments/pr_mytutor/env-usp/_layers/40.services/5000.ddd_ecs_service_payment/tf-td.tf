module "task_def" {
  source                             = "../../../../../../libft/generic-modules/deployment/service/task_definition"
  container_definition_template_path = "${path.module}/tpl/task_definitions/service.json.tpl"
  container_definition_params = {
    cache_entrypoint             = var.outputs_cache_cache_entrypoint[0]
    cognito_user_pool            = var.outputs_cognito_cognito_app_pool_id
    docker_registry_url          = aws_ecr_repository.ecr.repository_url
                                   # "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_ecr_region}.amazonaws.com/usp_service_${var.service_name}"
    spring_profiles_active       = var.spring_profiles_active
    server_base_url              = var.server_base_url
    server_domain                = var.server_domain
    bucket_name                  = var.outputs_s3_s3_bucket_name
    service_name                 = var.service_name
    platform_name                = var.platform_name
    redis_cache_expiration_time  = 600
    redis_port                   = 6379
    manual                       = true
  }
  service_name         = var.service_name
  service_version      = var.service_version
  execution_role_arn   = aws_iam_role.task_execution_role.arn
  task_role_arn        = aws_iam_role.task_role.arn
  autoscaling_config   = local.autoscaling[var.label["Environment"]]
  aws_region           = var.label["Region"]
  tag_description      = var.tag_description
  task_additional_tags = module.label.tags
  label                = module.label.tags
}
