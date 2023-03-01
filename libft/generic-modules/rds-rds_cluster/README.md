# RDS cluster Terraform Submodule for phoenix #

This Terraform submodule creates the base RDS cluster infrastructure on AWS for phoenix App.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name      | Version |
|-----------|---------|
| terraform | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| aws  | n/a     |

## Resources

| Name |
|------|
|  |
|  |

## Structure
This module consists of next submodules (resources):
1. `submodule`
2. `resource`



## Usage

You can use this module to create a ...

### Example (resources)

This simple example creates a ... :

```

```

Aurora MySQL 2.x (MySQL 5.7)

```
resource "aws_rds_cluster" "default" {
  cluster_identifier      = "aurora-cluster-demo"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.03.2"
  availability_zones      = ["us-west-2a", "us-west-2b", "us-west-2c"]
  database_name           = "mydb"
  master_username         = "foo"
  master_password         = "bar"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
}
```

Aurora MySQL 1.x (MySQL 5.6)
```
resource "aws_rds_cluster" "default" {
  cluster_identifier      = "aurora-cluster-demo"
  availability_zones      = ["us-west-2a", "us-west-2b", "us-west-2c"]
  database_name           = "mydb"
  master_username         = "foo"
  master_password         = "bar"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
}
```

Aurora with PostgreSQL engine
```
resource "aws_rds_cluster" "postgresql" {
  cluster_identifier      = "aurora-cluster-demo"
  engine                  = "aurora-postgresql"
  availability_zones      = ["us-west-2a", "us-west-2b", "us-west-2c"]
  database_name           = "mydb"
  master_username         = "foo"
  master_password         = "bar"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
}
```

Aurora Multi-Master Cluster
```
resource "aws_rds_cluster" "example" {
  cluster_identifier   = "example"
  db_subnet_group_name = aws_db_subnet_group.example.name
  engine_mode          = "multimaster"
  master_password      = "barbarbarbar"
  master_username      = "foo"
  skip_final_snapshot  = true
}
```

### Example (module)

This more complete example creates a rds-cluster module using a detailed configuration. Please check the example folder to get the example with all options:

```
module "rds-aurora" {
  source                                    = "./aliases/rds-cluster"

  app                                       = ""
  env                                       = var.env
  create_cluster                            = true

  restore_point_source_cluster_identifier   = ""
  s3_source_engine_version                  = ""
  s3_bucket_name                            = ""
  s3_ingestion_role                         = ""
  s3_source_engine                          = ""

  db_subnet_group_name                      = "${var.app}-${var.env}"
  db_cluster_identifier                     = "${var.app}-${var.env}-cluster"
  db_engine                                 = var.db_engine
  db_engine_mode                            = var.db_engine_mode
  db_engine_version                         = null
  db_skip_final_snapshot                    = true
  db_apply_immediately                      = true
  db_storage_encrypted                      = true
  db_name                                   = var.env
  db_master_username                        = var.db_master_username
  publicly_accessible                       = true # for temporary configuration
  replica_scale_enabled                     = false
  replica_count                             = 0

  db_scaling_configuration = {
    auto_pause               = true
    min_capacity             = 2
    max_capacity             = 4
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }
}
```


## Inputs

| Name                                     | Description                                                                                                                                                                                                                                                                                                                                                                               | Type          | Default                  | Required |
|------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|--------------------------|----------|
| app                                      | App name                                                                                                                                                                                                                                                                                                                                                                                  | `string`      | "phoenix"                 | yes      |
| env                                      | Environment                                                                                                                                                                                                                                                                                                                                                                               | `string`      | n/a                      | yes      |
| availability_zones                       | A list of EC2 Availability Zones for the DB cluster storage where DB cluster instances can be created. RDS automatically assigns 3 AZs if less than 3 AZs are configured, which will show as a difference requiring resource recreation next Terraform apply. It is recommended to specify 3 AZs or use the lifecycle configuration block ignore_changes argument if necessary            | `list(any)`   | n/a                      | no       |
| create_cluster                           | Boolean variable that decides create rds cluster or not. Default is true                                                                                                                                                                                                                                                                                                                                                                                         | `bool`        | n/a                   | yes       |
| db_allow_major_version_upgrade           | Enable to allow major engine version upgrades when changing engine versions. Defaults to false                                                                                                                                                                                                                                                                                            | `bool`        | `false`                  | no       |
| db_apply_immediately                     | Specifies whether any cluster modifications are applied immediately, or during the next maintenance window. Default is false                                                                                                                                                                                                                                                              | `bool`        | `false`                  | no       |
| db_backtrack_window                      | The target backtrack window, in seconds. Only available for aurora engine currently. To disable backtracking, set this value to 0. Defaults to 0. Must be between 0 and 259200 (72 hours)                                                                                                                                                                                                 | `number`      | 0                        | no       |
| db_backup_retention_period               | The days to retain backups for                                                                                                                                                                                                                                                                                                                                                            | `number`      | 7                        | no       |
| db_cluster_identifier_prefix             | Creates a unique cluster identifier beginning with the specified prefix. Conflicts with cluster_identifier                                                                                                                                                                                                                                                                                | `string`      | n/a                      | no       |
| db_cluster_identifier                    | The cluster identifier. If omitted, Terraform will assign a random, unique identifier                                                                                                                                                                                                                                                                                                     | `string`      | n/a                      | no       |
| db_copy_tags_to_snapshot                 | Copy all Cluster tags to snapshots. Default is false                                                                                                                                                                                                                                                                                                                                      | `bool`        | `false`                  | no       |
| db_name                                  | Name for an automatically created database on cluster creation. There are different naming restrictions per database engine: RDS Naming Constraints                                                                                                                                                                                                                                       | `string`      | n/a                      | no       |
| db_cluster_parameter_group_name          | A cluster parameter group to associate with the cluster                                                                                                                                                                                                                                                                                                                                   | `string`      | `null`                   | no       |
| db_subnet_group_name                     | A DB subnet group to associate with this DB instance. NOTE: This must match the db_subnet_group_name specified on every aws_rds_cluster_instance in the cluster                                                                                                                                                                                                                           | `string`      | n/a                      | no       |
| db_deletion_protection                   | If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true                                                                                                                                                                                                                                                                  | `bool`        | `false`                  | no       |
| db_enable_http_endpoint                  | Enable HTTP endpoint (data API). Only valid when engine_mode is set to serverless                                                                                                                                                                                                                                                                                                         | `bool`        | `true`                   | no       |
| db_enable_cloudwatch_logs_exports        | Set of log types to export to cloudwatch. If omitted, no logs will be exported. The following log types are supported: audit, error, general, slowquery, postgresql (PostgreSQL)                                                                                                                                                                                                          | `string`      | "audit"                  | no       |
| db_engine_mode                           | The database engine mode. Valid values: global (only valid for Aurora MySQL 1.21 and earlier), multimaster, parallelquery, provisioned, serverless. Defaults to: provisioned. See the RDS User Guide for limitations when using serverless                                                                                                                                                | `string`      | n/a                      | no       |
| db_engine_version                        | The database engine version. Updating this argument results in an outage. See the Aurora MySQL and Aurora Postgres documentation for your configured engine to determine this value. For example with Aurora MySQL 2, a potential value for this argument is 5.7.mysql_aurora.2.03.2                                                                                                      | `string`      | n/a                      | no       |
| db_engine                                | The name of the database engine to be used for this DB cluster. Defaults to aurora. Valid Values: aurora, aurora-mysql, aurora-postgresql                                                                                                                                                                                                                                                 | `string`      | "aurora"                 | no       |
| db_final_snapshot_identifier             | The name of your final DB snapshot when this DB cluster is deleted. If omitted, no final snapshot will be made                                                                                                                                                                                                                                                                            | `string`      | "final"                  | no       |
| db_global_cluster_identifier             | The global cluster identifier specified on aws_rds_global_cluster                                                                                                                                                                                                                                                                                                                         | `string`      | n/a                      | no       |
| db_iam_database_authentication_enabled   | Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled. Please see AWS Documentation for availability and limitations                                                                                                                                                                                                         | `bool`        | `false`                  | no       |
| db_iam_roles                             | A List of ARNs for the IAM roles to associate to the RDS Cluster                                                                                                                                                                                                                                                                                                                          | `list(any)`   | n/a                      | no       |
| db_kms_key_id                            | The ARN for the KMS encryption key. When specifying kms_key_id, storage_encrypted needs to be set to true                                                                                                                                                                                                                                                                                 | `string`      | n/a                      | no       |
| *db_master_password                      | (Required unless a snapshot_identifier or replication_source_identifier is provided or unless a global_cluster_identifier is provided when the cluster is the 'secondary' cluster of a global database) Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file. Please refer to the RDS Naming Constraints                          | `string`      | "root"                   | yes      |
| *db_master_username                      | (Required unless a snapshot_identifier or replication_source_identifier is provided or unless a global_cluster_identifier is provided when the cluster is the 'secondary' cluster of a global database) Username for the master DB user. Please refer to the RDS Naming Constraints. This argument does not support in-place updates and cannot be changed during a restore from snapshot | `string`      | "root"                   | yes      |
| db_port                                  | The port on which the DB accepts connections                                                                                                                                                                                                                                                                                                                                              | `string`      | "5432"                   | no       |
| db_preferred_backup_window               | The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter.Time in UTC. Default: A 30-minute window selected at random from an 8-hour block of time per region. e.g. 04:00-09:00                                                                                                                          | `string`      | "02:00-03:00"            | no       |
| db_preferred_maintenance_window          | The weekly time range during which system maintenance can occur, in (UTC) e.g. wed:04:00-wed:04:30                                                                                                                                                                                                                                                                                        | `string`      | "sun:05:00-sun:06:00"    | no       |
| db_replication_source_identifier         | ARN of a source DB cluster or DB instance if this DB cluster is to be created as a Read Replica. If DB Cluster is part of a Global Cluster, use the lifecycle configuration block ignore_changes argument to prevent Terraform from showing differences for this argument instead of configuring this value                                                                               | `string`      | n/a                      | no       |
| *db_restore_to_point_in_time             | Nested attribute for point in time restore                                                                                                                                                                                                                                                                                                                                                | `string`      | n/a                      | no       |
| *db_scaling_configuration                | Nested attribute with scaling properties. Only valid when engine_mode is set to serverless                                                                                                                                                                                                                                                                                                | `map(string)` | n/a                      | no       |
| db_skip_final_snapshot                   | Determines whether a final DB snapshot is created before the DB cluster is deleted. If true is specified, no DB snapshot is created. If false is specified, a DB snapshot is created before the DB cluster is deleted, using the value from final_snapshot_identifier                                                                                                                     | `bool`        | false                    | no       |
| db_snapshot_identifier                   | Specifies whether or not to create this cluster from a snapshot. You can use either the name or ARN when specifying a DB cluster snapshot, or the ARN when specifying a DB snapshot                                                                                                                                                                                                       | `string`      | n/a                      | no       |
| db_source_region                         | The source region for an encrypted replica DB cluster                                                                                                                                                                                                                                                                                                                                     | `string`      | n/a                      | no       |
| db_storage_encrypted                     | Specifies whether the DB cluster is encrypted. The default is false for provisioned engine_mode and true for serverless engine_mode. When restoring an unencrypted snapshot_identifier, the kms_key_id argument must be provided to encrypt the restored cluster. Terraform will only perform drift detection if a configuration value is provided                                        | `bool`        | true                     | no       |
| db_vpc_security_group_ids                | List of VPC security groups to associate with the Cluster                                                                                                                                                                                                                                                                                                                                 | `list(any)`   | n/a                      | no       |
| db_tags                                  | A map of tags to assign to the DB cluster                                                                                                                                                                                                                                                                                                                                                 | `map(string)` | n/a                      | no       |
| s3_bucket_name                           | The bucket name where your backup is stored                                                                                                                                                                                                                                                                                                                                               | `string`      | n/a                      | yes      |
| s3_ingestion_role                        | Role applied to load the data                                                                                                                                                                                                                                                                                                                                                             | `string`      | n/a                      | yes      |
| s3_source_engine                         | Source engine for the backup                                                                                                                                                                                                                                                                                                                                                              | `string`      | n/a                      | yes      |
| s3_source_engine_version                 | Version of the source engine used to make the backup                                                                                                                                                                                                                                                                                                                                      | `string`      | n/a                      | yes      |
| s3_bucket_prefix                         | Can be blank, but is the path to your backup                                                                                                                                                                                                                                                                                                                                              | `string`      | n/a                      | no       |
| restore_point_source_cluster_identifier  | The identifier of the source database cluster from which to restore                                                                                                                                                                                                                                                                                                                       | `string`      | n/a                      | yes      |
| restore_point_restore_type               | Type of restore to be performed. Valid options are full-copy (default) and copy-on-write                                                                                                                                                                                                                                                                                                  | `string`      | "full-copy"              | no       |
| restore_point_use_latest_restorable_time | Set to true to restore the database cluster to the latest restorable backup time. Defaults to false. Conflicts with restore_to_time                                                                                                                                                                                                                                                       | `bool`        | `false`                  | no       |
| restore_point_restore_to_time            | Date and time in UTC format to restore the database cluster to. Conflicts with use_latest_restorable_time                                                                                                                                                                                                                                                                                 | `string`      | n/a                      | no       |
| scaling_auto_pause                       | Whether to enable automatic pause. A DB cluster can be paused only when it's idle (it has no connections). If a DB cluster is paused for more than seven days, the DB cluster might be backed up with a snapshot. In this case, the DB cluster is restored when there is a request to connect to it                                                                                       | `bool`        | `true`                   | no       |
| scaling_max_capacity                     | The maximum capacity for an Aurora DB cluster in serverless DB engine mode. The maximum capacity must be greater than or equal to the minimum capacity. Valid Aurora MySQL capacity values are 1, 2, 4, 8, 16, 32, 64, 128, 256. Valid Aurora PostgreSQL capacity values are (2, 4, 8, 16, 32, 64, 192, and 384)                                                                          | `number`      | 16                       | no       |
| scaling_min_capacity                     | The minimum capacity for an Aurora DB cluster in serverless DB engine mode. The minimum capacity must be lesser than or equal to the maximum capacity. Valid Aurora MySQL capacity values are 1, 2, 4, 8, 16, 32, 64, 128, 256. Valid Aurora PostgreSQL capacity values are (2, 4, 8, 16, 32, 64, 192, and 384)                                                                           | `number`      | 1                        | no       |
| scaling_seconds_until_auto_pause         | The time, in seconds, before an Aurora DB cluster in serverless mode is paused. Valid values are 300 through 86400                                                                                                                                                                                                                                                                        | `number`      | 300                      | no       |
| *scaling_seconds_until_auto_pause         | The action to take when the timeout is reached. Valid values: ForceApplyCapacityChange, RollbackCapacityChange                                                                                                                                                                                                                                                                            | `string`      | "RollbackCapacityChange" | no       |
| replica_scale_enabled                    |Enables of disables replica scaling                                                                                                                                                                                                                                                                                                                                                                                           | `string`      | "/"                      | no       |
| replica_count                            |Count of the replicas                                                                                                                                                                                                                                                                                                                                                                                           | `string`      | "/"                      | no       |
| replica_scale_min                        |Minimum count of replicas                                                                                                                                                                                                                                                                                                                                                                                           | `string`      | "2"                      | no       |
| *final_snapshot_identifier_prefix        |Prefix of the final snapshot identifier                                                                                                                                                                                                                                                                                                                                                                                           | `string`      | "final"                  | no       |
| auto_minor_version_upgrade               |Auto upgrade of the minor version                                                                                                                                                                                                                                                                                                                                                                                           | `bool`        | `true`                   | no       |
| *promotion_tier                          |Promotion tier                                                                                                                                                                                                                                                                                                                                                                                           | `string`      | 0                        | no       |
| performance_insights_enabled             |Enables of disables performance insights                                                                                                                                                                                                                                                                                                                                                                                           | `bool`        | false                    | no       |
| publicly_accessible                      |Decides is cluster publicly accessible or not                                                                                                                                                                                                                                                                                                                                                                                           | `bool`        | `false`                  | no       |



## Outputs

| Name                                     | Description                                                                                 |
|------------------------------------------|---------------------------------------------------------------------------------------------|
| db_cluster_arn                           | Amazon Resource Name (ARN) of cluster                                                       |
| db_cluster_id                            | The RDS Cluster Identifier                                                                  |
| db_cluster_cluster_identifier            | The RDS Cluster Identifier                                                                  |
| db_cluster_cluster_resource_id           | The RDS Cluster Resource ID                                                                 |
| db_cluster_cluster_members               | List of RDS Instances that are a part of this cluster                                       |
| db_cluster_availability_zones            | The availability zone of the instance                                                       |
| db_cluster_backup_retention_period       | The backup retention period                                                                 |
| db_cluster_preferred_backup_window       | The daily time range during which the backups happen                                        |
| db_cluster_preferred_maintenance_window  | The maintenance window                                                                      |
| db_cluster_endpoint                      | The DNS address of the RDS instance                                                         |
| db_cluster_reader_endpoint               | A read-only endpoint for the Aurora cluster, automatically load-balanced across replicas    |
| db_cluster_engine                        | The database engine                                                                         |
| db_cluster_engine_version                | The database engine version                                                                 |
| db_cluster_database_name                 | The database name                                                                           |
| db_cluster_port                          | The database port                                                                           |
| db_cluster_master_username               | The master username for the database                                                        |
| db_cluster_master_password               | The master password                                                                         |
| db_cluster_storage_encrypted             | Specifies whether the DB cluster is encrypted                                               |
| db_cluster_replication_source_identifier | ARN of the source DB cluster or DB instance if this DB cluster is created as a Read Replica |
| db_cluster_hosted_zone_id                | The Route53 Hosted Zone ID of the endpoint                                                  |



<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
