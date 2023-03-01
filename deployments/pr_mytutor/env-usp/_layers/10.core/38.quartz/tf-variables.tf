#--------------------------------------------------------------
# Connections
#--------------------------------------------------------------
#vpc
variable "outputs_vpc_vpc_id" {}
variable "outputs_vpc_public_subnets" {}
variable "outputs_vpc_vpc_cidr_block" {}
#--------------------------------------------------------------
# General
#--------------------------------------------------------------
variable "label" {}
variable "tag_role" {
  default = "primary_db"
}
variable "tf_framework_component_version" {
  description = "GIT tag or branch if no tag vailable, identifying terraform source code version being run. Set by Makefile Framework"
}

#--------------------------------------------------------------
# Bastion
#--------------------------------------------------------------
variable "ami" {
  default = "ami-0fcda042dd8ae41c7"
}

#--------------------------------------------------------------
# DB
#--------------------------------------------------------------
variable "skip_final_snapshot" {
  description = "Create backup(snapshot) before DB deleted? ref https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance"
  default     = true
}
variable "rds_db_scaling_auto_pause" {
  description = "TBD"
  default     = true // TBD revise
}
variable "rds_db_scaling_min_capacity" {
  description = "TBD"
  default     = 2 // TBD revise
}
variable "rds_db_scaling_max_capacity" {
  description = "TBD"
  default     = 4 // TBD revise
}
variable "rds_db_scaling_seconds_until_auto_pause" {
  description = "TBD"
  default     = 1800 // to revise
}
variable "rds_db_scaling_timeout_action" {
  description = "TBD"
  default     = "ForceApplyCapacityChange" // to revise
}
variable "aws_backup_region" {
  description = "Region we store backups into"
  default     = "us-east-2"
}
variable "backup_delete_after" {
  description = "how long we keed backups?"
  default     = { "dev" = 1, "qa" = 1, "staging" = "30", "prod" = "90" }
}
variable "backup_additional_tags" {
  description = "A map of additional tags, just tag/value pairs, to add to the backup module."
  type        = map(string)
  default     = { Jira = "TECHGEN-4570" }
}
variable "vpc_cidr" {}
