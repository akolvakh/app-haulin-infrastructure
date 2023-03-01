#--------------------------------------------------------------
# Connections
#--------------------------------------------------------------
variable "outputs_vpc_vpc_id" {}
variable "outputs_cache_cache_entrypoint" {}
variable "outputs_cognito_cognito_app_pool_id" {}
#variable "outputs_alb_alb_public_app_backends_api_gateway" {}
variable "outputs_alb_listener_arn" {}
variable "outputs_ecs_ecs_main_cluster_arn" {}
variable "outputs_ecs_ecs_main_cluster_name" {}
variable "outputs_service_discovery_service_discovery_private_dns_namespace_id" {}
variable "outputs_sg_sg_default_db_id" {}
variable "outputs_sg_sg_cache_id" {}
variable "outputs_sg_sg_alb_public_app_id" {}
#--------------------------------------------------------------
# General ETC Parameters
#--------------------------------------------------------------
variable "label" {}
variable "first_run" {}
variable "platform_name" {}
variable "tag_role" {
  default = "ecs_service"
}
variable "service_additional_tags" {
  type        = map(string)
  description = "map of additional tags to be added to service and it's tasks"
  default     = { "Jira" = "" }
}
variable "tag_description" {
  type    = string
  default = "Main APP  serivce to be split"
}
variable "spring_profiles_active" {
  type        = string
  description = "Active profile"
}
variable "tf_framework_component_version" {}
variable "doc_link_base" {
  type        = string
  description = "base url for wiki page holding documentation for the secret(s)"
  default     = "https://phoenix.atlassian.net/wiki/spaces/DOCUMENTAT/pages/471433238/Secrets+and+environment+specific+params"
}
variable "smoketest_emails" {
  type = string
}
variable "parameter_additional_tags" {
  type        = map(any)
  description = "add here any additional tags you want assign to parameters created"
  default     = {}
}
variable "external_dns_domain" {}
variable "boooknook_base_app_url" {}
variable "server_base_url" {}
variable "server_domain" {}
variable "allowed_origin_patterns" {}
variable "csrf_enabled" {}
variable "server_secret" {}
variable "phoenix_master_db_schema" {}

#--------------------------------------------------------------
# ECS
#--------------------------------------------------------------
variable "aws_ecr_region" {
  type    = string
  default = "us-east-1"
}
# variable "aws_ecr_account_id" {
#   type    = string
#   default = "343423493973"
# }
variable "service_name" {
  description = "name of service to deploy"
  default = "api-gateway"
}
variable "service_version" {
  description = "version to deploy"
  # DELETE
  default = "latest"
}
variable "limits_task_cpu" {
  description = <<EOF
     Value per service, should be preserved across envs. 
    ref https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html
    ref https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-cpu-memory-error.html
    
EOF
  // defaults arguably do not make sense, except just for dev/testing conveniency
  default = 1024
}
variable "limits_task_memory" {
  description = <<EOF
 Value per service, should be preserved across envs. 
    ref https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#container_definition_memory
    ref https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-cpu-memory-error.html
EOF
  // defaults arguably do not make sense, except just for dev/testing conveniency
  default = 2048
}