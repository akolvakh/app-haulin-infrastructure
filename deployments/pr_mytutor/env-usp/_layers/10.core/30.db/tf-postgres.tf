# provider "postgresql" {
#   host             = module.rds_aurora.db_cluster_endpoint
#   port             = module.rds_aurora.db_cluster_port
#   username         = module.rds_aurora.db_cluster_master_username
#   superuser        = false
#   password         = module.rds_aurora.db_cluster_master_password
#   sslmode          = "require"
#   expected_version = module.rds_aurora.db_cluster_engine_version_actual
#   connect_timeout  = 30
# }

# module "db_claims" {
#   source = "../../../generic-modules/rds_aurora/postgres_db"

#   db_name              = "${local.common_tags.Product}-${local.common_tags.Environment}-claims"
#   db_username          = "${local.common_tags.Product}-${local.common_tags.Environment}-claims"
#   db_connection_limit  = "10"
#   db_schema_name       = "${local.common_tags.Product}-${local.common_tags.Environment}-claims-schema"
#   db_statement_timeout = "120000"
#   db_secret_name       = "${local.name_prefix}/db/claims-service"

#   rds_cluster_endpoint        = module.rds_aurora.db_cluster_endpoint
#   rds_cluster_port            = module.rds_aurora.db_cluster_port
#   rds_cluster_master_username = module.rds_aurora.db_cluster_master_username
#   rds_cluster_master_password = module.rds_aurora.db_cluster_master_password
# }