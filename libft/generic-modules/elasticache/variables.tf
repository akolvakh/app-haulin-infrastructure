variable "subnet_ids" {
  type        = list(any)
  description = "security group(s) to attach to the Elasticache being creatad"
}

variable "subnet_group_name" {
  type    = string
  default = "subnet-grp" # Moving hardcoded subnet group name to a variable. This Module is not fully reusable! The default value was set to prevent unexpected recreation of the phoenix app cache subnet group.
}

variable "security_group_ids" {
  type        = list(any)
  description = "security group(s) to attach to the Elasticache being creatad"
}

variable "redis_node_type" {
  type        = string
  description = "type of instance for Redis nodes, ref https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/nodes-select-size.html"
  default     = "cache.t3.medium"
}
variable "transit_encryption_enabled" {
  type        = bool
  description = "enables SSL for data transsfer over network"
  default     = false
  /**
  APP/APIs to support
  */
}

variable "auth_enabled" {
  type        = bool
  description = "enables per user passwords and ACLs. Requires transit_encryption_enabled=true"
  default     = false
  /**
  APP/APIs to support
  */
}
variable "at_rest_encryption_enabled" {
  type        = bool
  description = "enables encryption for data storage"
  default     = false
}

variable "cluster_enabled" {
  type        = bool
  description = "create Redis scalable and highly available cluster( in Sharded mode)? Ref https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/CacheNodes.NodeGroups.html. By default - create cheap single node redis instance "
  default     = false
}
variable "cluster_replicas_per_node_group" {
  type        = number
  description = "in Sharded Redis cluster mode, how many replica per shard to create for HA"
  default     = 1
}
variable "cluster_num_node_groups" {
  type        = number
  description = "in Sharded Resi cluster mode, how many shards create"
  default     = 2
}
variable "number_cache_clusters" {
  type        = number
  description = "in NON sharded Redis mode, how many master=>slave replica copies create?"
  default     = 2
}

variable "redis_port" {
  type        = number
  description = "what prot Redis to listen on"
  default     = 6379
}


#--------------------------------------------------------------
# Tags
#--------------------------------------------------------------
# variable "tag_role" {
#   default = "cache_redis"
# }

# variable "tag_product" {
#   type        = string
#   description = "zytrar product to use this module"
# }
# variable "tag_contact" {
#   description = "valid mail address to reach for questions and issues. <env> repalced by current environment name"
#   // sadly TF does not let us substitute a variable inside a variable
#   default = "devops-team+<env>@phoenix.com"
# }

# variable "tag_environment" {
#   description = "environment to deploy into"
# }

# variable "tag_orchestration" {
#   description = "VCS link to TF source code leveraging this module"
# }

# variable "cache_additional_tags" {
#   type        = map(string)
#   description = "map of tags to be added to all resources created by this module"
#   default     = {}
# }

variable "tags" {}