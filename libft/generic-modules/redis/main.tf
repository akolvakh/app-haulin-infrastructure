#------------------------------------------------------------------------------
# General
#------------------------------------------------------------------------------
resource "random_string" "random" {
  length           = 16
  special          = true
  override_special = "/@£$"
}

locals {
  name = random_string.random.id
  tags = ""
}

#------------------------------------------------------------------------------
# Elasticache Subnet Group
#------------------------------------------------------------------------------
resource "aws_elasticache_subnet_group" "default" {
  count       = var.enable ? 1 : 0
  name        = local.name
  subnet_ids  = var.subnet_ids
  description = var.description
}

#------------------------------------------------------------------------------
# Elasticache Replication Group
#------------------------------------------------------------------------------
resource "aws_elasticache_replication_group" "default" {
  count                         = var.enable && var.replication_enabled ? 1 : 0
  engine                        = var.engine
  replication_group_id          = local.name
  replication_group_description = local.name
  engine_version                = var.engine_version
  port                          = var.port
  parameter_group_name          = "default.redis5.0"
  node_type                     = var.node_type
  automatic_failover_enabled    = var.automatic_failover_enabled
  subnet_group_name             = join("", aws_elasticache_subnet_group.default.*.name)
  security_group_ids            = var.security_group_ids
  security_group_names          = var.security_group_names
  snapshot_arns                 = var.snapshot_arns
  snapshot_name                 = var.snapshot_name
  notification_topic_arn        = var.notification_topic_arn
  snapshot_window               = var.snapshot_window
  snapshot_retention_limit      = var.snapshot_retention_limit
  apply_immediately             = var.apply_immediately
  availability_zones            = slice(var.availability_zones, 0, var.number_cache_clusters)
  number_cache_clusters         = var.number_cache_clusters
  auto_minor_version_upgrade    = var.auto_minor_version_upgrade
  maintenance_window            = var.maintenance_window
  at_rest_encryption_enabled    = var.at_rest_encryption_enabled
  transit_encryption_enabled    = var.transit_encryption_enabled
  auth_token                    = var.auth_token
  kms_key_id                    = var.kms_key_id
  tags                          = local.tags
}

#------------------------------------------------------------------------------
# Elasticache Replication Group Cluster
#------------------------------------------------------------------------------
resource "aws_elasticache_replication_group" "cluster" {
  count                         = var.enable && var.cluster_replication_enabled ? 1 : 0
  engine                        = var.engine
  replication_group_id          = local.name
  replication_group_description = local.name
  engine_version                = var.engine_version
  port                          = var.port
  parameter_group_name          = "default.redis5.0.cluster.on"
  node_type                     = var.node_type
  automatic_failover_enabled    = var.automatic_failover_enabled
  subnet_group_name             = join("", aws_elasticache_subnet_group.default.*.name)
  security_group_ids            = var.security_group_ids
  security_group_names          = var.security_group_names
  snapshot_arns                 = var.snapshot_arns
  snapshot_name                 = var.snapshot_name
  notification_topic_arn        = var.notification_topic_arn
  snapshot_window               = var.snapshot_window
  snapshot_retention_limit      = var.snapshot_retention_limit
  apply_immediately             = var.apply_immediately
  availability_zones            = slice(var.availability_zones, 0, var.num_node_groups)
  auto_minor_version_upgrade    = var.auto_minor_version_upgrade
  maintenance_window            = var.maintenance_window
  at_rest_encryption_enabled    = var.at_rest_encryption_enabled
  transit_encryption_enabled    = var.transit_encryption_enabled
  auth_token                    = var.auth_token
  kms_key_id                    = var.kms_key_id
  tags                          = local.tags
  cluster_mode {
    replicas_per_node_group = var.replicas_per_node_group #Replicas per Shard
    num_node_groups         = var.num_node_groups         #Number of Shards
  }
}