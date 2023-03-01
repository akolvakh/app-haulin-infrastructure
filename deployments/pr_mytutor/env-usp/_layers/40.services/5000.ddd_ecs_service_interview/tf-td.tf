module "task_def" {
  source                             = "../../../../../../libft/generic-modules/deployment/service/task_definition"
  container_definition_template_path = "${path.module}/tpl/task_definitions/service.json.tpl"
  container_definition_params = {
    db_main_entrypoint           = var.outputs_db_db_main_entrypoint
    docker_registry_url          = aws_ecr_repository.ecr.repository_url
    spring_profiles_active       = var.spring_profiles_active
    kafka_broker_list            = var.outputs_kafka_bootstrap_brokers
    service_name                 = var.service_name
    platform_name                = var.platform_name
    manual                       = false
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
