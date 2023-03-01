#------------------------------------------------------------------------------
# General variables
#------------------------------------------------------------------------------
variable "app" {
  description = "(Required) App name."
  type        = string
}

variable "env" {
  description = "(Required) Environment."
  type        = string
}

#------------------------------------------------------------------------------
# DB Subnet group variables
#------------------------------------------------------------------------------
variable "db_cluster_identifier" {
  description = "(Optional, Forces new resources) The cluster identifier. If omitted, Terraform will assign a random, unique identifier."
  type        = string
  default     = "/"
}

variable "db_subnet_group_name" {
  description = "(Optional) A DB subnet group to associate with this DB instance. NOTE: This must match the db_subnet_group_name specified on every aws_rds_cluster_instance in the cluster."
  type        = string
  default     = "/"
}

variable "description" {
  description = "(Optional) The description of db subnet group."
  type        = string
  default     = ""
}

variable "tags" {
  description = "(Optional) Key-value map of resource tags."
  type        = map(string)
  default = {
    Environment = "dev",
    App         = "phoenix",
    Name        = "phoenix-db-subnet-group"
  }
}

#------------------------------------------------------------------------------
# Subnet variables
#------------------------------------------------------------------------------
variable "subnet_ids" {
  description = "(Optional) IDs of the subnet."
  type        = list(any)
  default     = []
}
