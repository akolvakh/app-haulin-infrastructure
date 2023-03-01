#--------------------------------------------------------------
# Connections
#--------------------------------------------------------------
#sg
variable "outputs_sg_sg_cache_id" {}
#vpc
variable "outputs_vpc_vpc_id" {}
#--------------------------------------------------------------
# General
#--------------------------------------------------------------
variable "label" {}
variable "tag_role" {
  default = "cache_redis"
}
variable "tag_contact" {
  description = "valid mail address to reach for questions and issues. <env> repalced by current environment name"
  #TODO
  // sadly TF does not let us substitute a variable inside a variable
  default = "devops-team+<env>@product.com"
}
variable "tf_framework_component_version" {
  description = "GIT tag or branch if no tag vailable, identifying terraform source code version being run. Set by Makefile Framework"
}
variable "cache_additional_tags" {
  type        = map(string)
  description = "map of tags to be added to all resources created by this module"
  default     = {}
}

#--------------------------------------------------------------
# Redis
#--------------------------------------------------------------
variable "redis_node_type" {
  type        = string
  description = "type of instance for REdis nodes, ref https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/nodes-select-size.html"
  default     = "cache.t3.medium"
}
variable "cluster_enabled" {
  type    = bool
  default = false
}
variable "vpc_cidr" {}