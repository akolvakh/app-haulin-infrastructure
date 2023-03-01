#------------------------------------------------------------------------------
# LABEL
#------------------------------------------------------------------------------
variable "name" {
  description = "(Required) Name  (e.g. `app` or `cluster`)."
  type        = string
  default     = ""
}

variable "repository" {
  description = "(Required) Terraform current module repo."
  type        = string
  default     = "https://registry.terraform.io/modules/clouddrove/elasticache/aws/0.14.0"

  validation {
    error_message = "The module-repo value must be a valid Git repo link."
    # regex(...) fails if it cannot find a match
    condition = can(regex("^https://", var.repository))
  }
}

variable "environment" {
  description = "(Required) Environment (e.g. `prod`, `dev`, `staging`)."
  type        = string
  default     = ""
}

variable "label_order" {
  description = "Label order, e.g. `name`,`application`."
  type        = list(any)
  default     = []
}

variable "attributes" {
  description = "(Required) Additional attributes (e.g. `1`)."
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "(Optional) Additional tags (e.g. map(`BusinessUnit`,`XYZ`)."
  type        = map(any)
  default     = {}
}

variable "managedby" {
  description = "(Optional) ManagedBy, phoenix."
  type        = string
  default     = "phoenix@phoenix.com"
}

variable "enable" {
  description = "(Optional) Enable or disable of elasticache"
  type        = bool
  default     = true
}

#------------------------------------------------------------------------------
# Replication Group
#------------------------------------------------------------------------------
variable "engine" {
  description = "(Optional) The name of the cache engine to be used for the clusters in this replication group. e.g. redis."
  default     = ""
}

variable "replication_group_id" {
  description = "(Optional) The replication group identifier This parameter is stored as a lowercase string."
  default     = ""
  sensitive   = true
}

variable "automatic_failover_enabled" {
  description = "(Optional) Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. If true, Multi-AZ is enabled for this replication group. If false, Multi-AZ is disabled for this replication group. Must be enabled for Redis (cluster mode enabled) replication groups. Defaults to false."
  default     = false
}

variable "engine_version" {
  description = "(Optional) The version number of the cache engine to be used for the cache clusters in this replication group."
  default     = ""
}

variable "port" {
  description = "(Optional) the port number on which each of the cache nodes will accept connections."
  default     = ""
  sensitive   = true
}

variable "node_type" {
  description = "(Optional) The compute and memory capacity of the nodes in the node group."
  default     = "cache.t2.small"
}

variable "security_group_ids" {
  description = "(Optional) One or more VPC security groups associated with the cache cluster."
  default     = []
  sensitive   = true
}

variable "security_group_names" {
  description = "(Optional) A list of cache security group names to associate with this replication group."
  default     = null
}

variable "snapshot_arns" {
  description = "(Optional) A single-element string list containing an Amazon Resource Name (ARN) of a Redis RDB snapshot file stored in Amazon S3."
  default     = null
}

variable "snapshot_name" {
  description = "(Optional) The name of a snapshot from which to restore data into the new node group. Changing the snapshot_name forces a new resource."
  default     = ""
  sensitive   = true
}

variable "snapshot_window" {
  description = "(Optional) (Redis only) The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. The minimum snapshot window is a 60 minute period."
  default     = null
}

variable "snapshot_retention_limit" {
  description = "(Optional) (Redis only) The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. For example, if you set SnapshotRetentionLimit to 5, then a snapshot that was taken today will be retained for 5 days before being deleted. If the value of SnapshotRetentionLimit is set to zero (0), backups are turned off. Please note that setting a snapshot_retention_limit is not supported on cache.t1.micro or cache.t2.* cache nodes."
  default     = null
}

variable "notification_topic_arn" {
  description = "(Optional) An Amazon Resource Name (ARN) of an SNS topic to send ElastiCache notifications to."
  default     = ""
  sensitive   = true
}

variable "apply_immediately" {
  description = "(Optional) Specifies whether any modifications are applied immediately, or during the next maintenance window. Default is false."
  default     = false
}

variable "subnet_ids" {
  description = "(Optional) List of VPC Subnet IDs for the cache subnet group."
  default     = []
  sensitive   = true
}

variable "description" {
  description = "(Optional) Description for the cache subnet group. Defaults to `Managed by Terraform`."
  type        = string
  default     = "Managed by Terraform"
}

variable "availability_zones" {
  description = "(Required) A list of EC2 availability zones in which the replication group's cache clusters will be created. The order of the availability zones in the list is not important."
  type        = list(string)
}

variable "number_cache_clusters" {
  description = "(Required for Cluster Mode Disabled) The number of cache clusters (primary and replicas) this replication group will have. If Multi-AZ is enabled, the value of this parameter must be at least 2. Updates will occur before other modifications."
  type        = string
  default     = ""
}

variable "auto_minor_version_upgrade" {
  description = "(Optional) Specifies whether a minor engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window. Defaults to true."
  default     = true
}

variable "maintenance_window" {
  description = "(Optional) Maintenance window."
  default     = "sun:05:00-sun:06:00"
}

variable "at_rest_encryption_enabled" {
  description = "(Optional) Enable encryption at rest."
  default     = true
}

variable "transit_encryption_enabled" {
  description = "(Optional) Whether to enable encryption in transit."
  default     = true
}

variable "auth_token" {
  description = "(Optional) The password used to access a password protected server. Can be specified only if transit_encryption_enabled = true."
  default     = "gihweisdjhewiuei"
}

variable "family" {
  description = "(Required) The family of the ElastiCache parameter group."
  default     = ""
}

variable "replication_enabled" {
  description = "(Optional) (Redis only) Enabled or disabled replication_group for redis standalone instance."
  type        = bool
  default     = false
}

variable "cluster_replication_enabled" {
  description = "(Optional) (Redis only) Enabled or disabled replication_group for redis cluster."
  type        = bool
  default     = false
}

#------------------------------------------------------------------------------
# Cluster
#------------------------------------------------------------------------------
variable "cluster_enabled" {
  description = "(Optional) Enabled or disabled cluster."
  type        = bool
  default     = false
}

variable "num_cache_nodes" {
  description = "(Required unless replication_group_id is provided) The initial number of cache nodes that the cache cluster will have. For Redis, this value must be 1."
  default     = 1
}

variable "replicas_per_node_group" {
  description = "(Optional) Replicas per Shard."
  default     = ""
}

variable "num_node_groups" {
  description = "(Optional) Number of Shards (nodes)."
  default     = ""
}

variable "kms_key_id" {
  description = "(Optional) The ARN of the key that you wish to use if encrypting at rest. If not supplied, uses service managed encryption. Can be specified only if at_rest_encryption_enabled = true."
  default     = ""
  sensitive   = true
}

variable "parameter_group_name" {
  description = "(Optional) The name of the parameter group to associate with this replication group. If this argument is omitted, the default cache parameter group for the specified engine is used."
  type        = string
  default     = ""
}