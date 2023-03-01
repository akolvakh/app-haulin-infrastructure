#------------------------------------------------------------------------------
# General variables
#------------------------------------------------------------------------------
variable "app" {
  description = "(Required) App name."
  type        = string
  default     = "phoenix"
}

variable "env" {
  description = "(Required) Environment."
  type        = string
  default     = "dev"
}

#------------------------------------------------------------------------------
# ECS variables
#------------------------------------------------------------------------------
variable "ecs_name" {
  description = "(Optional) The name of the cluster (up to 255 letters, numbers, hyphens, and underscores)"
  type        = string
  default     = "phoenix"
}

variable "ecs_capacity_providers" {
  description = "(Optional) List of short names of one or more capacity providers to associate with the cluster. Valid values also include FARGATE and FARGATE_SPOT."
  type        = string
  default     = "FARGATE"
}

variable "ecs_tags" {
  description = "(Optional) Key-value map of resource tags."
  type        = map(string)
  default = {
    Environment = "dev",
    App         = "phoenix",
    Name        = "phoenix-ecs"
  }
}

#------------------------------------------------------------------------------
# Setting variables
#------------------------------------------------------------------------------
variable "setting_name" {
  description = "(Optional) Name of the setting to manage. Valid values: containerInsights."
  type        = string
  default     = "containerInsights"
}

#ToDo Check: CKV_AWS_65: "Ensure container insights are enabled on ECS cluster"
variable "setting_value" {
  description = "(Optional) The value to assign to the setting. Value values are enabled and disabled."
  type        = string
  #
  default = "enabled"
}

#------------------------------------------------------------------------------
# Dcps variables (default capacity provider strategy)
#------------------------------------------------------------------------------
variable "dcps_capacity_provider" {
  description = "(Optional) The short name of the capacity provider."
  type        = string
  default     = "FARGATE"
}

variable "dcps_weight" {
  description = "(Optional) The relative percentage of the total number of launched tasks that should use the specified capacity provider."
  type        = number
  default     = 50
}

variable "dcps_base" {
  description = "(Optional) The number of tasks, at a minimum, to run on the specified capacity provider. Only one capacity provider in a capacity provider strategy can have a base defined."
  type        = number
  default     = 2
}
