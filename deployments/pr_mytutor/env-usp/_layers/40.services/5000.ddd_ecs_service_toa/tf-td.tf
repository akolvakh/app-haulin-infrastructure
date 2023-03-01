module "task_def" {
  source                             = "../../../../../../libft/generic-modules/deployment/service/task_definition"
  container_definition_template_path = "${path.module}/tpl/task_definitions/service.json.tpl"
  container_definition_params = {
    db_main_entrypoint           = var.outputs_db_db_main_entrypoint
    docker_registry_url          = "014703753464.dkr.ecr.eu-west-1.amazonaws.com/mytutor/tutor-onboarding-application-be"
                                   # var.first_run ? aws_ecr_repository.ecr.repository_url : "014703753464.dkr.ecr.eu-west-1.amazonaws.com/mytutor/tutor-onboarding-application-be"
                                   # "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_ecr_region}.amazonaws.com/service_${var.service_name}"
    spring_profiles_active                  = var.spring_profiles_active
    kafka_broker_list                       = var.outputs_kafka_bootstrap_brokers
    service_name                            = var.service_name
    s3                                      = module.s3.s3_bucket_bucket
    db_url                                  = "jdbc:postgresql://${var.outputs_db_db_main_entrypoint}:5432/${var.label["Environment"]}?ssl=true&sslmode=require&currentSchema=application"
    platform_name                           = var.platform_name
    kafka_security_protocol                 = "PLAINTEXT"
    spring_kafka_producer_security_protocol = "PLAINTEXT"
    spring_kafka_consumer_security_protocol = "PLAINTEXT"
    manual                                  = false
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
