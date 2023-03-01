variable "service_name" {
  description = "name of service to deploy"
}
variable "cluster_name" {
  description = "name of ECS cluster to put service into"
  //example data.terraform_remote_state.ecs.outputs.ecs_main_cluster_name
}
variable "td_arn" {
  description = "task definition arn"
  //example aws_ecs_task_definition.td.arn
}
variable "desired_count" {
  description = "how many tasks have"
  //example local.autoscaling[local.common_tags.Environment].autoscaling_desired_task_count
}
variable "network_subnets_ids" {
  description = "array of subnet ids to launch tasks in"
  //example data.aws_subnet_ids.services_subnets.ids
}
variable "network_security_groups" {
  description = "IDs of security groups to assign to the service's tasks"
  //example [data.terraform_remote_state.sg.outputs.sg_ecs_service_names_2_sg_id_map[var.service_name]]
}
variable "health_check_grace_seconds" {
  type        = number
  description = "how many seconds ignore healthcheck failure. For slow to start apps. Like phoenix BE as of now"
  default     = 250
}

variable "load_balancer_target_group_arn" {
  description = "arn of an LB target group to place service into, required"
  //example data.terraform_remote_state.alb.outputs.alb_public_app_backends_api_name_2_tgt_grp_map[var.service_name]
}
variable "tag_description" {
  type        = string
  description = "short and meaningful description - Waht is this service?"
}
variable "service_additional_tags" {
  type        = map(string)
  description = "optional Map of tags to add to service being created"
  default     = {}
}

variable "registry_arn" {}

# variable "label" {}