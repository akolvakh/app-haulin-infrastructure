variable "db_name" {
  type        = string
  description = "The name of the database. Must be unique on the PostgreSQL server instance where it is configured" 
}

variable "db_username" {
  type        = string
  description = "The name of the role (DB username)"
}

variable "db_schema_name" {
  type        = string
  description = "The name of the schema. Must be unique in the PostgreSQL database instance where it is configured"
}

variable "db_connection_limit" {
  type        = string
  default     = 10
  description = "If this role can log in, this specifies how many concurrent connections the role can establish"
}

variable "db_statement_timeout" {
  type        = string
  default     = 120000 # 2 minutes
  description = "Milliseconds. Allows to abort any statement that takes more than the specified amount of time"
}

variable "db_secret_name" {
  type        = string
  description = "The name of the secret with DB credentials in the AWS SecretsManager"
}

variable "rds_cluster_endpoint" {
  type        = string
  description = "DNS address of the RDS cluster"
}

variable "rds_cluster_port" {
  type        = string
  description = "RDS cluster port"
  default     = 5432
}

variable "rds_cluster_master_username" {
  type = string
}

variable "rds_cluster_master_password" {
  type      = string
  sensitive = true
}