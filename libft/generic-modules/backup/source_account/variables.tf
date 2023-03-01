variable "aws_region" {
  description = "what region to create resources in"
}

variable "aws_region_central_backup" {
  description = "What region in AWS Central backup account we copy local backups into?"
}
variable "backup_acct_id" {
  description = "id of AWS account configured be central backup account"
}
variable "central_backup_acct_destination_vault_name" {
  description = "vault name in central backup account, where the local account backup service sends copies into. Example: module.config_backup_vault.backup_vault_name[default_db][environment] "
}
variable "central_backup_acct_event_bus_name" {
  description = "Name of even bus in central backup account.Backup code in Source Account copies data into Centrla Backup Acct hosted Vault and sends notification on that into Central Backup Acct hosted event bus. Example: module.config_backup_vault.backup_event_bus_name[var.environment]} . At least use one per environment, to prevent cross environment failures propagation via centrla backup account"
}

variable "backup_by_tag_value" {
  description = "RDS DB cloud reources marked by tag 'backup_type' with this value will be backed up"
}
variable "backup_schedule" {
  description = "cron expression for aws_backup_plan. Example: cron(0 5 ? * * *) "
}
variable "backup_vault_kms_key_arn" {
  type        = string
  description = "ARN of KMS key to be used to encrypt backup vault in local account. Should allow Write access to Centrla Backup account for the sake of restore"
}
variable "backup_name_prefix" {
  type        = string
  description = "name prefix for cloud resoruces created by this module"
  default     = "backup"
}
variable "backup_delete_after" {
  description = "how long we keed backups, days?"
}
variable "backup_additional_tags" {
  description = "A map of additional tags, just tag/value pairs, to add to the backup module."
  type        = map(string)
  default     = { Jira = "TECHGEN-4570" }
}
variable "backup_vault_policy_override_json" {
  type        = string
  description = "JSON of AWS Iam policy to be added to default backup vault policy in current account"
  default     = ""
}
variable "description" {
  description = "short and meaningful descriptino for data/clous resources to be backed up by this module"
}
variable "enable_rds_continuous_backup" {
  description = "Should enable RDS Point In Time Recovery, aka Continuous Backup?"
  default     = false
}
