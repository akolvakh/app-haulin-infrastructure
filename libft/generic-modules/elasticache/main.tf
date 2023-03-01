resource "random_id" "cache" {
  byte_length = 4
}
resource "aws_elasticache_subnet_group" "default" {
  name        = var.subnet_group_name
  subnet_ids  = var.subnet_ids
  description = "Subnet Grp for Elastic Cache" // Why so inconsistent? Some resourcs have the Desc field, most of them have nothing and rely on tags
  tags = merge(
    {
      "Name" = join(
        ".",
        [
          var.tags["Product"],
          var.tags["Environment"],
          "elasticache_subnet_grp",
        ],
      )
      "Description" = "Subnet Grp for Elastic Cache"
    },
    var.tags,
  )
}

resource "aws_elasticache_replication_group" "cluster" {
  count                         = var.cluster_enabled ? 1 : 0
  replication_group_id          = join("-", [var.tags["Product"], var.tags["Environment"], "cluster", random_id.cache.dec])
  replication_group_description = "test description"
  node_type                     = var.redis_node_type
  port                          = var.redis_port
  parameter_group_name          = var.cluster_enabled ? "default.redis6.x.cluster.on" : "default.redis6.x"
  automatic_failover_enabled    = var.cluster_enabled
  engine_version                = "6.x"
  security_group_ids            = var.security_group_ids
  subnet_group_name             = aws_elasticache_subnet_group.default.name
  apply_immediately             = true
  at_rest_encryption_enabled    = true
  transit_encryption_enabled    = var.transit_encryption_enabled // will enable - need cooperate with APP code here
  multi_az_enabled              = var.cluster_enabled
  cluster_mode {
    replicas_per_node_group = var.cluster_replicas_per_node_group
    num_node_groups         = var.cluster_num_node_groups
  }
  tags = merge(
    {
      "Name" = join(
        ".",
        [
          var.tags["Product"],
          var.tags["Environment"],
          "elasticache_subnet_grp",
        ],
      )
      "Description" = "Elastic Cache with Cluster Mode=ON and HA"
    },
    var.tags,
  )
}
/**
cheap config to save money in DEV account. No HA, no sharding. Terraform enforces us be verbose
*/
resource "aws_elasticache_replication_group" "non_cluster" {
  count                         = var.cluster_enabled ? 0 : 1
  replication_group_id          = substr(join("-", [var.tags["Product"], var.tags["Environment"], "non-cluster", random_id.cache.dec]), 0, 40)
  replication_group_description = "test description"
  node_type                     = var.redis_node_type
  port                          = var.redis_port
  parameter_group_name          = "default.redis6.x"
  automatic_failover_enabled    = false
  engine_version                = "6.x"
  security_group_ids            = var.security_group_ids
  subnet_group_name             = aws_elasticache_subnet_group.default.name
  apply_immediately             = true
  at_rest_encryption_enabled    = true
  transit_encryption_enabled    = var.transit_encryption_enabled // will enable - need cooperate with APP code first here
  multi_az_enabled              = false
  number_cache_clusters         = 1
  tags = merge(
    {
      "Name" = join(
        ".",
        [
          var.tags["Product"],
          var.tags["Environment"],
          "elasticache_subnet_grp",
        ],
      )
      "Description" = "Elastic Cache with Cluster Mode=OFF no HA single node - cheap"
    },
    var.tags,
  )
}
