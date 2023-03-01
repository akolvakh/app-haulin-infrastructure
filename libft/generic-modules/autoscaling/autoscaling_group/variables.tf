#------------------------------------------------------------------------------
# General variables
#------------------------------------------------------------------------------
variable "app" {
  description = "(Required) App name."
  type        = string
}

variable "env" {
  description = "(Required) Environment."
  type        = string
}

#------------------------------------------------------------------------------
# Launch configuration variables
#------------------------------------------------------------------------------
variable "name" {
  description = "(Required) The name of the auto scaling group."
  type        = string
}

variable "max_size" {
  description = "(Required) The maximum size of the auto scale group."
  type        = number
}

variable "min_size" {
  description = "(Required) The minimum size of the auto scale group."
  type        = number
}

variable "desired_capacity" {
  description = "(Required) The number of Amazon EC2 instances that should be running in the group."
  type        = number
}

variable "vpc_zone_identifier" {
  description = "(Required) A list of subnet IDs to launch resources in."
  type        = list(any)
}

variable "default_cooldown" {
  description = "(Optional) The amount of time, in seconds, after a scaling activity completes before another scaling activity can start."
  type        = number
  default     = 300
}

variable "launch_configuration" {
  description = "(Required) The name of the launch configuration to use."
  type        = string
}

variable "health_check_grace_period" {
  description = "(Optional) Time (in seconds) after instance comes into service before checking health."
  type        = number
  default     = 300
}

variable "health_check_type" {
  description = "(Required) Controls how health checking is done. Values are - EC2 and ELB."
  type        = string
}

variable "force_delete" {
  description = "(Optional) Allows deleting the autoscaling group without waiting for all instances in the pool to terminate. You can force an autoscaling group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling."
  type        = bool
  default     = false
}

variable "load_balancers" {
  description = "(Optional) A list of elastic load balancer names to add to the autoscaling group names."
  type        = list(string)
  default     = []
}

variable "target_group_arns" {
  description = "(Optional) A list of aws_alb_target_group ARNs, for use with Application Load Balancing."
  type        = list(string)
  default     = []
}

variable "termination_policies" {
  description = "(Optional) A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default."
  type        = list(any)
  default     = ["Default"]
}

variable "suspended_processes" {
  description = "(Optional) A list of processes to suspend for the AutoScaling Group. The allowed values are Launch, Terminate, HealthCheck, ReplaceUnhealthy, AZRebalance, AlarmNotification, ScheduledActions, AddToLoadBalancer. Note that if you suspend either the Launch or Terminate process types, it can prevent your autoscaling group from functioning properly."
  type        = list(string)
  default     = []
}

variable "placement_group" {
  description = "(Optional) The name of the placement group into which you'll launch your instances, if any."
  type        = string
  default     = ""
}

variable "metrics_granularity" {
  description = "(Optional) The granularity to associate with the metrics to collect. The only valid value is 1Minute."
  type        = string
  default     = "1Minute"
}

variable "enabled_metrics" {
  description = "(Optional) A list of metrics to collect. The allowed values are GroupMinSize, GroupMaxSize, GroupDesiredCapacity, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances."
  type        = list(any)
  default = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]
}

variable "wait_for_capacity_timeout" {
  description = "(Optional) A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior."
  type        = string
  default     = "10m"
}

variable "min_elb_capacity" {
  description = "(Optional) Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes."
  type        = number
  default     = 0
}

variable "wait_for_elb_capacity" {
  description = "(Optional) Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over min_elb_capacity behavior."
  type        = bool
  default     = false
}

variable "protect_from_scale_in" {
  description = "(Optional) Allows setting instance protection. The autoscaling group will not select instances with this setting for terminination during scale in events."
  type        = bool
  default     = false
}

variable "tags" {
  description = "(Optional) A map of tags to assign to the resource."
  type        = map(string)
  default = {
    Environment = "dev",
    App         = "phoenix",
    Name        = "phoenix-autoscaling"
  }
}
