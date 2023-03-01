output "backup_vault_name" {
  value = {
    "description" = "name for cross account vault(s). To replace by convention in next version"
    "default_db" = {
      "dev"     = substr("${data.aws_default_tags.default.tags["Product"]}_dev_default_db", 0, 50)
      "qa"      = substr("${data.aws_default_tags.default.tags["Product"]}_qa_default_db", 0, 50)
      "staging" = substr("${data.aws_default_tags.default.tags["Product"]}_staging_default_db", 0, 50)
      "prod"    = substr("${data.aws_default_tags.default.tags["Product"]}_prod_default_db", 0, 50)
      "experimental"    = substr("${data.aws_default_tags.default.tags["Product"]}_experimental_default_db", 0, 50)
    }
  }

}

output "backup_account_primary_region" {
  value       = "us-east-1"
  description = "AWS Region where primary backup  vaults(source of multi regional copies) of Backup account"
}

output "backup_event_bus_name" {
  description = "name of EventBus instance, one per env, to be use by environments to send notification into Backup account about backups to pickup"
  value = {
    "dev"     = "backup_from_dev"
    "qa"      = "backup_from_qa"
    "staging" = "backup_from_staging"
    "prod"    = "backup_from_prod"
    "experimental"    = "backup_from_experimental"
  }
}
