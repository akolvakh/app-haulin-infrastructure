module "task_def" {
  source                             = "../../../../../../libft/generic-modules/deployment/service/task_definition"
  container_definition_template_path = "${path.module}/tpl/task_definitions/service.json.tpl"
  container_definition_params = {
    cache_entrypoint              = var.outputs_cache_cache_entrypoint[0]
    cognito_user_pool             = var.outputs_cognito_cognito_app_pool_id
    db_main_entrypoint            = var.outputs_db_db_main_entrypoint
    db_quartz_entrypoint          = var.outputs_db_db_quartz_entrypoint
    docker_registry_url           = aws_ecr_repository.ecr.repository_url
    spring_profiles_active        = var.spring_profiles_active
    kafka_broker_list             = var.outputs_kafka_bootstrap_brokers
    server_base_url               = var.server_base_url
    server_domain                 = var.server_domain
    bucket_name                   = var.outputs_s3_s3_bucket_name
    boooknook_base_app_url        = var.boooknook_base_app_url
    service_name                  = var.service_name
    email_from_domain             = var.email_from_domain
    lesson_integration_service    = var.label["Product"] == "uss" ? "LS" : "BN"
    platform_name                 = var.platform_name
    job_enable                    = true
    manual                        = false
    redis_port                    = 6379
    redis_cache_expiration_time   = 600
    spring_datasource_url         = "jdbc:postgresql://${var.outputs_db_db_main_entrypoint}:5432/phoenix_app_${module.label.tags["Environment"]}_default?ssl=true&sslmode=require"
    booknook_api_url              = "https://api-qa.booknooklearning.com"
    lessonspace_api_url           = "https://thelessonspace.com"
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
