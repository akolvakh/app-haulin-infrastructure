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

variable "availability_zones" {
  description = "(Optional) A list of EC2 Availability Zones for the DB cluster storage where DB cluster instances can be created. RDS automatically assigns 3 AZs if less than 3 AZs are configured, which will show as a difference requiring resource recreation next Terraform apply. It is recommended to specify 3 AZs or use the lifecycle configuration block ignore_changes argument if necessary."
  type        = list(any)
  default     = []
}

variable "create_cluster" {
  description = "(Required) Boolean variable that decides create rds cluster or not. Default is true."
  type        = bool
}

#------------------------------------------------------------------------------
# DB variables
#------------------------------------------------------------------------------
variable "db_allow_major_version_upgrade" {
  description = "(Optional) Enable to allow major engine version upgrades when changing engine versions. Defaults to false."
  type        = bool
  default     = false
}

variable "db_apply_immediately" {
  description = "(Optional) Specifies whether any cluster modifications are applied immediately, or during the next maintenance window. Default is false."
  type        = bool
  default     = false
}

variable "db_backtrack_window" {
  description = "(Optional) The target backtrack window, in seconds. Only available for aurora engine currently. To disable backtracking, set this value to 0. Defaults to 0. Must be between 0 and 259200 (72 hours)."
  type        = number
  default     = 0
}

variable "db_backup_retention_period" {
  description = "(Optional) The days to retain backups for. Default 1."
  type        = number
  default     = 7
}

variable "db_cluster_identifier_prefix" {
  description = "(Optional, Forces new resource) Creates a unique cluster identifier beginning with the specified prefix. Conflicts with cluster_identifier."
  type        = string
  default     = "/"
}

variable "db_cluster_identifier" {
  description = "(Optional, Forces new resources) The cluster identifier. If omitted, Terraform will assign a random, unique identifier."
  type        = string
}

variable "db_copy_tags_to_snapshot" {
  description = "(Optional, boolean) Copy all Cluster tags to snapshots. Default is false."
  type        = bool
  default     = false
}

variable "db_name" {
  description = "(Optional) Name for an automatically created database on cluster creation. There are different naming restrictions per database engine: RDS Naming Constraints."
  type        = string
  default     = "phoenix-db"
}

variable "db_cluster_parameter_group_name" {
  description = "(Optional) A cluster parameter group to associate with the cluster."
  type        = string
  default     = null
}

variable "db_subnet_group_name" {
  description = "(Optional) A DB subnet group to associate with this DB instance. NOTE: This must match the db_subnet_group_name specified on every aws_rds_cluster_instance in the cluster."
  type        = string
  default     = "db-subnet-group"
}

#ToDo Check: CKV_AWS_139: "Ensure that RDS clusters have deletion protection enabled"
variable "db_deletion_protection" {
  description = "(Optional) If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true. The default is false."
  type        = bool
  //  default     = false
  default = true
}

variable "db_enable_http_endpoint" {
  description = "(Optional) Enable HTTP endpoint (data API). Only valid when engine_mode is set to serverless."
  type        = bool
  default     = true
}

variable "db_enable_cloudwatch_logs_exports" {
  description = "(Optional) Set of log types to export to cloudwatch. If omitted, no logs will be exported. The following log types are supported: audit, error, general, slowquery, postgresql (PostgreSQL)."
  type        = string
  default     = "audit"
}

variable "db_engine_mode" {
  description = "(Optional) The database engine mode. Valid values: global (only valid for Aurora MySQL 1.21 and earlier), multimaster, parallelquery, provisioned, serverless. Defaults to: provisioned. See the RDS User Guide for limitations when using serverless."
  type        = string
  default     = "provisioned"
}

#
variable "db_engine_version" {
  description = "(Optional) The database engine version. Updating this argument results in an outage. See the Aurora MySQL and Aurora Postgres documentation for your configured engine to determine this value. For example with Aurora MySQL 2, a potential value for this argument is 5.7.mysql_aurora.2.03.2."
  type        = string
  default     = "/"
}

variable "db_engine" {
  description = "(Optional) The name of the database engine to be used for this DB cluster. Defaults to aurora. Valid Values: aurora, aurora-mysql, aurora-postgresql."
  type        = string
  default     = "aurora"
}

variable "db_final_snapshot_identifier" {
  description = "(Optional) The name of your final DB snapshot when this DB cluster is deleted. If omitted, no final snapshot will be made."
  type        = string
  default     = "final"
}

variable "db_global_cluster_identifier" {
  description = "(Optional) The global cluster identifier specified on aws_rds_global_cluster."
  type        = string
  default     = ""
}

#ToDo Check: CKV_AWS_128: "Ensure that an Amazon RDS Clusters have AWS Identity and Access Management (IAM) authentication enabled"
variable "db_iam_database_authentication_enabled" {
  description = "(Optional) Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled. Please see AWS Documentation for availability and limitations."
  type        = bool
  //  default     = false
  default = true
}

variable "db_iam_roles" {
  description = "(Optional) A List of ARNs for the IAM roles to associate to the RDS Cluster."
  type        = list(any)
  default     = []
}

variable "db_kms_key_id" {
  description = "(Optional) The ARN for the KMS encryption key. When specifying kms_key_id, storage_encrypted needs to be set to true."
  type        = string
  default     = null
}

variable "db_master_password" {
  description = "(Required unless a snapshot_identifier or replication_source_identifier is provided or unless a global_cluster_identifier is provided when the cluster is the 'secondary' cluster of a global database) Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file. Please refer to the RDS Naming Constraints."
  type        = string
  default     = "root"
}

variable "db_master_username" {
  description = "(Required unless a snapshot_identifier or replication_source_identifier is provided or unless a global_cluster_identifier is provided when the cluster is the 'secondary' cluster of a global database) Username for the master DB user. Please refer to the RDS Naming Constraints. This argument does not support in-place updates and cannot be changed during a restore from snapshot."
  type        = string
  default     = "root"
}

variable "db_port" {
  description = "(Optional) The port on which the DB accepts connections."
  type        = string
  default     = "5432"
}

variable "db_preferred_backup_window" {
  description = "(Optional) The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter.Time in UTC. Default: A 30-minute window selected at random from an 8-hour block of time per region. e.g. 04:00-09:00."
  type        = string
  default     = "02:00-03:00"
}

variable "db_preferred_maintenance_window" {
  description = "(Optional) The weekly time range during which system maintenance can occur, in (UTC) e.g. wed:04:00-wed:04:30."
  type        = string
  default     = "sun:05:00-sun:06:00"
}

variable "db_replication_source_identifier" {
  description = "(Optional) ARN of a source DB cluster or DB instance if this DB cluster is to be created as a Read Replica. If DB Cluster is part of a Global Cluster, use the lifecycle configuration block ignore_changes argument to prevent Terraform from showing differences for this argument instead of configuring this value."
  type        = string
  default     = ""
}

variable "scaling_configuration" {
  description = "(Required) Nested attribute with scaling properties. Only valid when engine_mode is set to serverless. More details below."
  type        = map(string)
}

variable "db_skip_final_snapshot" {
  description = "(Optional) Determines whether a final DB snapshot is created before the DB cluster is deleted. If true is specified, no DB snapshot is created. If false is specified, a DB snapshot is created before the DB cluster is deleted, using the value from final_snapshot_identifier. Default is false."
  type        = bool
  default     = false
}

variable "db_snapshot_identifier" {
  description = "(Optional) Specifies whether or not to create this cluster from a snapshot. You can use either the name or ARN when specifying a DB cluster snapshot, or the ARN when specifying a DB snapshot."
  type        = string
  default     = ""
}

variable "db_source_region" {
  description = "(Optional) The source region for an encrypted replica DB cluster."
  type        = string
  default     = "us-east-1"
}

#ToDo Check: CKV_AWS_96: "Ensure all data stored in Aurora is securely encrypted at rest"
variable "db_storage_encrypted" {
  description = "(Optional) Specifies whether the DB cluster is encrypted. The default is false for provisioned engine_mode and true for serverless engine_mode. When restoring an unencrypted snapshot_identifier, the kms_key_id argument must be provided to encrypt the restored cluster. Terraform will only perform drift detection if a configuration value is provided."
  type        = bool
  default     = true
}

variable "db_vpc_security_group_ids" {
  description = "(Optional) List of VPC security groups to associate with the Cluster."
  type        = list(any)
  default     = []
}

variable "db_tags" {
  description = "(Optional) A map of tags to assign to the DB cluster."
  type        = map(string)
  default = { //"dev" env can not be reasonable default, To review all RDS. Phil 
    Environment = "dev",
    App         = "phoenix",
    Name        = "phoenix-db"
  }
}

#------------------------------------------------------------------------------
# S3 Import Options variables
#------------------------------------------------------------------------------
variable "s3_bucket_name" {
  description = "(Optional) The bucket name where your backup is stored."
  type        = string
  default     = ""
}

variable "s3_ingestion_role" {
  description = "(Optional) Role applied to load the data."
  type        = string
  default     = ""
}

variable "s3_source_engine" {
  description = "(Optional) Source engine for the backup."
  type        = string
  default     = ""
}

variable "s3_source_engine_version" {
  description = "(Optional) Version of the source engine used to make the backup."
  type        = string
  default     = ""
}

variable "s3_bucket_prefix" {
  description = "(Optional) Can be blank, but is the path to your backup."
  type        = string
  default     = "/"
}

#------------------------------------------------------------------------------
# Restore to Point in Time variables
#------------------------------------------------------------------------------
variable "restore_point_source_cluster_identifier" {
  description = "(Required) The identifier of the source database cluster from which to restore."
  type        = string
  default     = ""
}

variable "restore_point_restore_type" {
  description = "(Optional) Type of restore to be performed. Valid options are full-copy (default) and copy-on-write."
  type        = string
  default     = "full-copy"
}

variable "restore_point_use_latest_restorable_time" {
  description = "(Optional) Set to true to restore the database cluster to the latest restorable backup time. Defaults to false. Conflicts with restore_to_time."
  type        = bool
  default     = false
}

variable "restore_point_restore_to_time" {
  description = "(Optional) Date and time in UTC format to restore the database cluster to. Conflicts with use_latest_restorable_time."
  type        = string
  default     = "/"
}

#------------------------------------------------------------------------------
# Scaling Configuration variables
#------------------------------------------------------------------------------
variable "scaling_auto_pause" {
  description = "(Optional) Whether to enable automatic pause. A DB cluster can be paused only when it's idle (it has no connections). If a DB cluster is paused for more than seven days, the DB cluster might be backed up with a snapshot. In this case, the DB cluster is restored when there is a request to connect to it. Defaults to true."
  type        = bool
  default     = true
}

variable "scaling_max_capacity" {
  description = "(Optional) The maximum capacity for an Aurora DB cluster in serverless DB engine mode. The maximum capacity must be greater than or equal to the minimum capacity. Valid Aurora MySQL capacity values are 1, 2, 4, 8, 16, 32, 64, 128, 256. Valid Aurora PostgreSQL capacity values are (2, 4, 8, 16, 32, 64, 192, and 384). Defaults to 16."
  type        = number
  default     = 4 //16
}

variable "scaling_min_capacity" {
  description = "(Optional) The minimum capacity for an Aurora DB cluster in serverless DB engine mode. The minimum capacity must be lesser than or equal to the maximum capacity. Valid Aurora MySQL capacity values are 1, 2, 4, 8, 16, 32, 64, 128, 256. Valid Aurora PostgreSQL capacity values are (2, 4, 8, 16, 32, 64, 192, and 384). Defaults to 1."
  type        = number
  default     = 2
}

variable "scaling_seconds_until_auto_pause" {
  description = "(Optional) The time, in seconds, before an Aurora DB cluster in serverless mode is paused. Valid values are 300 through 86400. Defaults to 300."
  type        = number
  default     = 300
}

#------------------------------------------------------------------------------
# RDS Cluster variables
#------------------------------------------------------------------------------
variable "replica_scale_enabled" {
  description = "(Optional) Enables of disables replica scaling."
  type        = bool
  default     = true
}

variable "replica_count" {
  description = "(Optional) Count of the replicas."
  type        = string
  default     = "2"
}

variable "replica_scale_min" {
  description = "(Optional) Minimum count of replicas."
  type        = string
  default     = "2"
}

variable "final_snapshot_identifier_prefix" {
  description = "(Optional) Prefix of the final snapshot identifier."
  type        = string
  default     = "final"
}

variable "auto_minor_version_upgrade" {
  description = "(Optional) Auto upgrade of the minor version."
  type        = bool
  default     = true
}

variable "promotion_tier" {
  description = "(Optional) Promotion tier."
  type        = string
  default     = 0
}

variable "performance_insights_enabled" {
  description = "(Optional) Enables of disables performance insights."
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  description = "(Optional) Decides is cluster publicly accessible or not."
  type        = bool
  default     = false
}
