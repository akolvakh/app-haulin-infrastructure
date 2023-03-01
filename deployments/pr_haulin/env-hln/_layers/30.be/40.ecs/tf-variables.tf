#--------------------------------------------------------------
# General
#--------------------------------------------------------------
variable "label" {}
variable "tf_framework_component_version" {
  description = "GIT tag or branch if no tag vailable, identifying terraform source code version being run. Set by Makefile Framework"
}

#--------------------------------------------------------------
# ECS
#--------------------------------------------------------------
variable "cluster_default_capacity_provider" {
  type        = string
  description = "ecs cluster default capacity provider, FARGATE|FARGATE_SPOT"
  default     = "FARGATE"
}
variable "ecs_service_name_2_ecr_url_map" {
  type        = map(string)
  description = "map of service names to docker repos to grab images from. To be set by CI/CD"
  default     = {}
}
variable "docker_registry_url" {
  type        = string
  description = "url of ECR repo"
  default     = "528677244674.dkr.ecr.us-east-1.amazonaws.com"
}
variable "ecs_desired_task_count" {
  default = 2
}
variable "vpc_cidr" {}