module "task_def" {
  source                             = "../../../../../../libft/generic-modules/deployment/service/task_definition"
  container_definition_template_path = "${path.module}/tpl/task_definitions/service.json.tpl"
  container_definition_params = {
    cache_entrypoint             = var.outputs_cache_cache_entrypoint[0]
    cognito_user_pool            = var.outputs_cognito_cognito_app_pool_id
    db_main_entrypoint           = var.outputs_db_db_main_entrypoint
    db_quartz_entrypoint         = var.outputs_db_db_quartz_entrypoint
    docker_registry_url          = aws_ecr_repository.ecr.repository_url
                                   # "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_ecr_region}.amazonaws.com/usp_service_${var.service_name}"
    spring_profiles_active       = var.spring_profiles_active
    kafka_broker_list            = var.outputs_kafka_bootstrap_brokers
    server_base_url              = var.server_base_url
    server_domain                = var.server_domain
    aws_bucket_id                = var.outputs_s3_s3_bucket_name
    service_name                 = var.service_name
    platform_name                = var.platform_name
    spring_datasource_url        = "jdbc:postgresql://${var.outputs_db_db_main_entrypoint}:5432/phoenix_app_${module.label.tags["Environment"]}_default?ssl=true&sslmode=require"
    redis_cache_expiration_time  = 600
    redis_port                   = 6379
    kafka_application_updates_topic_name = "domain.application.update"
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
