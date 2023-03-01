#--------------------------------------------------------------
# DB Backup
#--------------------------------------------------------------
# module "backup_2_central_acct" {
#   source                                     = "../../../../libft/generic-modules/backup/source_account"
#   backup_acct_id                             = module.shared_config_backup_acct.backup_account
#   backup_delete_after                        = var.backup_delete_after[var.environment]
#   aws_region                                 = var.aws_region
#   aws_region_central_backup                  = module.config_backup_vault.backup_account_primary_region
#   backup_by_tag_value                        = "db_default"
#   central_backup_acct_destination_vault_name = module.shared_config_backup_vault.backup_vault_name["default_db"]["${var.environment}"]
#   backup_schedule                            = "cron(0 5 ? * * *)"
#   central_backup_acct_event_bus_name         = module.shared_config_backup_vault.backup_event_bus_name[var.environment]
#   description                                = "backup for default aka legacy DB"
#   backup_vault_kms_key_arn                   = module.backup_kms_key.key_arn
# }

# module "backup_kms_key" {
#   //has to be CMK for the sake of cross account encrypted backups. AWS enfroces that
#   source               = "../../../../libft/generic-modules/kms_key/"
#   key_name             = "key-4-vault"
#   description          = "${module.label.tags["Product"]}-app RDS backup encryption/decryption crossa ccount key"
#   policy_override_json = data.aws_iam_policy_document.backup2_kmskey.json
#   key_additional_tags  = { "JIRA" = "TECHGEN-4570" }
# }

# /**
# Backup cross accout.
# AWS never shares AWS generated keys cross account. We define one explicitly and share it.
# */
# data "aws_iam_policy_document" "backup2_kmskey" {

#   statement {
#     sid = "backupKeyAllowCentrlBackupAccountRead"
#     principals {
#       type        = "AWS"
#       identifiers = ["*"] // TODO how I put here central account backup service identity?
#     }
#     actions = [
#       "kms:CreateGrant",
#       "kms:Decrypt",
#       "kms:GenerateDataKey*",
#       "kms:DescribeKey"
#     ]
#     resources = ["*"] //inline policy, star is harmless here
#     condition {
#       test     = "StringEquals"
#       variable = "kms:CallerAccount"
#       values   = [module.config_backup_acct.backup_account]
#     }
#   }
# }
