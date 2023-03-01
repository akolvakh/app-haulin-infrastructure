variable "service_name" {
  description = "name of service being depoyed"
}
variable "service_version" {
  description = "version of service being deployed"
}
variable "tag_description" {
  type = string
}
variable "tag_role" {
  description = "arbitrary name we can use for budget epxenses grouping by"
  default     = "ecs_service"
}
variable "execution_role_arn" {
  type        = string
  description = "IAM role ARN for running AWS gears when initialize the service"
}
variable "task_role_arn" {
  type        = string
  description = "IAM role ARN to be impersonated by code of the ervice being deployed"
}
variable "autoscaling_config" {
  description = "Map of app autoscaling config key value items"
  // example local.autoscaling[local.common_tags.Environment]
}
variable "aws_region" {
  description = "region where we deploy the resources into"
}
variable "container_definition_template_path" {
  description = "will be passed to TF function templatefile()"
  //example "${path.module}/tpl/task_definitions/service_be.json.tpl"
}
variable "container_definition_params" {
  type        = map(string)
  description = "Optional map of Key=>Value pairs, to fill in contaiener definition template"
}
variable "task_additional_tags" {
  type        = map(string)
  description = "optional Map of tags to add to service being created"
  default     = {}
}