#WE NEED VPC-PEERING FROM C9 MACHINE TO MAKE ALL DEPLOYMENTS FOR DB WITH POSTGRES PROVIDER


terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    postgresql = {
      source = "cyrilgdn/postgresql"
    }
  }
}

resource "random_password" "user" {
  length  = 30
  special = false
}

resource "postgresql_role" "role" {
  name              = "${var.db_username}-role" # role name
  login             = false
  connection_limit  = var.db_connection_limit
  statement_timeout = var.db_statement_timeout
}

resource "postgresql_role" "user" {
  name              = "${var.db_username}-user" # username
  login             = true
  inherit           = true
  roles             = [ postgresql_role.role.name ]
  password          = random_password.user.result
  connection_limit  = var.db_connection_limit
  statement_timeout = var.db_statement_timeout
}

resource "postgresql_database" "this" {
  name             = var.db_name
  owner            = postgresql_role.role.name
  connection_limit = var.db_connection_limit
}

resource "postgresql_schema" "this" {
  name     = var.db_schema_name
  database = postgresql_database.this.name
  owner    = postgresql_role.role.name

  # postgresql_role.role.name can create new objects in the schema. This is the role that
  # migrations are executed as.
  policy {
    create = true
    usage  = true
    role   = postgresql_role.role.name
  }
  
  policy {
    create = false
    usage  = false
    role   = "PUBLIC" 
  }
}

resource "postgresql_default_privileges" "this" {
  for_each = toset( ["sequence", "table", "function", "type"] )

  role     = postgresql_role.role.name
  database = postgresql_database.this.name
  schema   = postgresql_schema.this.name
  owner    = postgresql_role.role.name
  
  object_type = each.key
  privileges  = ["ALL"]
}

resource "postgresql_default_privileges" "public" {
  for_each = toset( ["sequence", "table", "function", "type"] )
  
  role     = "public"
  database = postgresql_database.this.name
  schema   = postgresql_schema.this.name
  owner    = postgresql_role.role.name
  object_type = each.key
  privileges  = []
}

resource "postgresql_grant" "revoke_public" {
  role     = "public"
  database = postgresql_database.this.name
  
  object_type = "database"
  privileges  = []
}

resource "postgresql_grant" "public_schema" {
  role     = "public"
  database = postgresql_database.this.name
  schema   = "public"
  
  object_type = "schema"
  privileges  = []
}

resource "postgresql_grant" "connect" {
  database    = postgresql_database.this.name
  role        = postgresql_role.role.name
  object_type = "database"
  privileges  = [ "CONNECT", "TEMPORARY" ]
}

resource "postgresql_grant" "connect_master" {
  database    = postgresql_database.this.name
  role        = var.rds_cluster_master_username
  object_type = "database"
  privileges  = [ "CONNECT" ]
}

resource "aws_secretsmanager_secret" "db_creds" {
  name = var.db_secret_name
}

resource "aws_secretsmanager_secret_version" "db_creds" {
  secret_id = aws_secretsmanager_secret.db_creds.id
  secret_string = jsonencode({
    db_name              = postgresql_database.this.name
    db_user              = postgresql_role.user.name
    password             = random_password.user.result
    host                 = var.rds_cluster_endpoint
    schema               = postgresql_schema.this.name
    pg_connection_string = "postgresql://${postgresql_role.user.name}:${random_password.user.result}@${var.rds_cluster_endpoint}:5432/${postgresql_database.this.name}" 
  })
}