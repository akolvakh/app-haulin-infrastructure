#------------------------------------------------------------------------------
# General
#------------------------------------------------------------------------------
data "aws_availability_zones" "available" {}

resource "random_password" "master_password" {
  length  = 10
  special = false
}

resource "random_id" "snapshot_identifier" {
  byte_length = 4
}

#------------------------------------------------------------------------------
# RDS Cluster
#------------------------------------------------------------------------------
resource "aws_rds_cluster" "main" {

  port                      = var.db_port
  global_cluster_identifier = var.db_global_cluster_identifier
  snapshot_identifier       = var.db_snapshot_identifier

  #ToDo Check: CKV_AWS_96: "Ensure all data stored in Aurora is securely encrypted at rest"
  //  storage_encrypted                   = var.db_storage_encrypted
  storage_encrypted = true



  cluster_identifier            = var.db_cluster_identifier
  replication_source_identifier = var.db_replication_source_identifier
  source_region                 = var.db_source_region
  engine                        = var.db_engine
  engine_mode                   = var.db_engine_mode
  engine_version                = var.db_engine_version
  enable_http_endpoint          = var.db_enable_http_endpoint
  database_name                 = var.db_name
  master_username               = var.db_master_username
  master_password               = element(concat(random_password.master_password.*.result, [""]), 0)
  final_snapshot_identifier     = "${var.final_snapshot_identifier_prefix}-${var.db_cluster_identifier}-${element(concat(random_id.snapshot_identifier.*.hex, [""]), 0)}"
  skip_final_snapshot           = var.db_skip_final_snapshot


  #ToDo Check: CKV_AWS_139: "Ensure that RDS clusters have deletion protection enabled"
  deletion_protection = var.db_deletion_protection


  backup_retention_period         = var.db_backup_retention_period
  preferred_backup_window         = var.db_preferred_backup_window
  preferred_maintenance_window    = var.db_preferred_maintenance_window
  db_subnet_group_name            = var.db_subnet_group_name
  vpc_security_group_ids          = var.db_vpc_security_group_ids
  apply_immediately               = var.db_apply_immediately
  db_cluster_parameter_group_name = var.db_cluster_parameter_group_name

  #ToDo Check: CKV_AWS_128: "Ensure that an Amazon RDS Clusters have AWS Identity and Access Management (IAM) authentication enabled"
  #  Error: error creating RDS cluster: InvalidParameterCombination: Aurora Serverless currently doesn't support IAM Authentication.
  #  status code: 400, request id: bf0d0596-f927-4e2d-843e-2f140add60ee
  #  on .terraform/modules/environment.rds_aurora.rds_aurora/rds_aurora/rds_cluster/main.tf line 18, in resource "aws_rds_cluster" "main":
  #  18: resource "aws_rds_cluster" "main" {

  //  iam_database_authentication_enabled = var.db_iam_database_authentication_enabled
  iam_database_authentication_enabled = false


  backtrack_window      = var.db_backtrack_window
  copy_tags_to_snapshot = var.db_copy_tags_to_snapshot
  iam_roles             = var.db_iam_roles

  tags = merge({
    Name        = var.db_cluster_identifier
    Terraform   = true
    App         = var.app
    Environment = "${var.app}-${var.env}"
  }, var.db_tags)
  kms_key_id = var.db_kms_key_id
  lifecycle {
    ignore_changes = [
      source_region,   // when restoed from backup it is set
      master_password, // should be subject to rotation, immediately after fresh RDS spinup
    ]
  }
  dynamic "scaling_configuration" {
    for_each = length(keys(var.scaling_configuration)) == 0 ? [] : [var.scaling_configuration]
    content {
      auto_pause               = lookup(scaling_configuration.value, "auto_pause", null)
      max_capacity             = lookup(scaling_configuration.value, "max_capacity", null)
      min_capacity             = lookup(scaling_configuration.value, "min_capacity", null)
      seconds_until_auto_pause = lookup(scaling_configuration.value, "seconds_until_auto_pause", null)
      timeout_action           = lookup(scaling_configuration.value, "timeout_action", null)
    }
  }
}
