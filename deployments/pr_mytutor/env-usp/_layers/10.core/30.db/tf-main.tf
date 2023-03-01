#--------------------------------------------------------------
# ETC
#--------------------------------------------------------------
resource "random_string" "suffix" {
  length  = 8
  special = false
}

#------------------------------------------------------------------------------
# DB Subnet Group
#------------------------------------------------------------------------------
module "db_subnet_group" {
  source               = "../../../../../../libft/generic-modules/rds-db_subnet_group"
  app                  = module.label.tags["Product"]
  env                  = module.label.tags["Environment"]
  db_subnet_group_name = "${module.label.id}"
  description          = "DB subnet group for Aurora Serverless Postgresql."
  subnet_ids           = data.aws_subnet_ids.db_subnet.ids
  tags                 = module.label.tags
}

#------------------------------------------------------------------------------
# RDS cluster parameter group
#------------------------------------------------------------------------------
resource "aws_rds_cluster_parameter_group" "rds_aurora" {
  name        = "${module.label.id}-parameter-group-v11"
  family      = "aurora-postgresql11"
  description = "${module.label.id} parameter group"
  tags        = module.label.tags
  parameter {
    name  = "rds.force_ssl"
    value = "1"
  }
  parameter {
    #TODO
    //why DEV DB is so CPU active and costly in DEV only?
    // Log rotation - N/A for serverless aurora, it exports to cloudwatch automatically per https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraPostgreSQL.CloudWatch.html
    // https://aws.amazon.com/blogs/database/audit-amazon-aurora-database-logs-for-connections-query-patterns-and-more-using-amazon-athena-and-amazon-quicksight/
    // "Audit logs in Aurora are rotated when they reach 100 MB. With your audit logs in CloudWatch, you gain control over how long you retain your logs in CloudWatch Logs."
    // Cw log group /aws/rds/cluster/cluster-name/log_type
    name  = "log_statement"
    value = "dev" == var.label["Environment"] ? "all" : "none"
  }
}

#------------------------------------------------------------------------------
# RDS Aurora Cluster
#------------------------------------------------------------------------------
module "rds_aurora" {
  source                 = "../../../../../../libft/generic-modules/rds-rds_cluster"
  create_cluster         = true
  app                    = module.label.tags["Product"]
  env                    = module.label.tags["Environment"]
  db_subnet_group_name   = module.db_subnet_group.db_subnet_group_name
  db_cluster_identifier  = "${module.label.id}"
  db_engine              = "aurora-postgresql"
  db_engine_mode         = "serverless"
  db_engine_version      = null //?
  publicly_accessible    = false
  replica_scale_enabled  = false
  replica_count          = 2
  db_skip_final_snapshot = var.skip_final_snapshot
  db_apply_immediately   = true
  db_storage_encrypted   = true
  db_name                = var.label["Environment"] // single DB schema for everything? we should revise app probably.
  //??? Lets create low privilged DB user/credentials. Not blocker for now
  #TODO
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.rds_aurora.name
  db_master_username              = "root" // TBD !!!
  scaling_configuration = {
    auto_pause               = var.rds_db_scaling_auto_pause
    min_capacity             = local.db_scaling[var.label["Environment"]].rds_db_scaling_min_capacity
    max_capacity             = local.db_scaling[var.label["Environment"]].rds_db_scaling_max_capacity
    seconds_until_auto_pause = var.rds_db_scaling_seconds_until_auto_pause
    timeout_action           = var.rds_db_scaling_timeout_action
  }
  db_vpc_security_group_ids = var.outputs_sg_sg_default_db_id
  // ID or arn? to reafacto rds tf module 
  # db_kms_key_id = module.db_kms_key.key_arn
  db_tags       = { "backup_type" = "db_default" }
}

# module "db_kms_key" {
#   //has to be CMK for the sake of backup access to KMS key. AWS enfroces that
#   source               = "../../../../libft/generic-modules/kms_key/"
#   key_name             = "${module.label.id}_db_default"
#   description          = "RDS DB storage encryption key "
#   policy_override_json = data.aws_iam_policy_document.db_kms_key.json
#   key_additional_tags  = module.label.tags
# }

# data "aws_iam_policy_document" "db_kms_key" {
#   statement {
#     sid = "AllowKeyUsageForRDSAndBackupCrossAcct"
#     //AWS by default does not let us use IAM for managing KMS key policy, but only by inline poliy attached to key itself
#     principals {
#       type = "AWS"
#       //it means local admins Can use IAM to grant/deny access to this key. It does not mean only root can do that
#       identifiers = [
#         "arn:aws:iam::${module.config_backup_acct.backup_account}:root",
#         "${module.backup_2_central_acct.backup_role_arn}",
#         data.aws_iam_role.rds_service.arn
#       ]
#     }
#     actions = [
#       "kms:Encrypt",
#       "kms:Decrypt",
#       "kms:ReEncrypt*",
#       "kms:GenerateDataKey*",
#       "kms:DescribeKey"
#     ]
#     // to keep AWS API happy. Star is meaningless here
#     resources = [
#       "*"
#     ]
#   }

#   statement {
#     sid = "AllowAttach2PersistentStorage"
#     principals {
#       type = "AWS"
#       identifiers = [
#         data.aws_iam_role.rds_service.arn,
#         "arn:aws:iam::${module.config_backup_acct.backup_account}:root"
#       ]
#     }
#     actions = [
#       "kms:CreateGrant",
#       "kms:ListGrants",
#       "kms:RevokeGrant"
#     ]
#     condition {
#       test     = "Bool"
#       variable = "kms:GrantIsForAWSResource"

#       values = [
#         "true"
#       ]
#     }
#     // to keep AWS API happy. Star is harmless here,inline attached resource only 
#     resources = [
#       "*"
#     ]
#   }
# }