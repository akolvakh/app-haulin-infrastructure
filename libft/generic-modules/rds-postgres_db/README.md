# Postgres Database submodule #

This Terraform submodule designed to create a database inside an RDS cluster while also keeping them isolated and preventing an app user from accessing other app’s databases.

## Requirements

| Name      | Version |
|-----------|---------|
| terraform | >= 0.13 |

## Providers

| Name      | Version |
|-----------|---------|
| postgresql| n/a     |

## Resources

| Name                |
|---------------------|
| postgresql_database |
| postgresql_role     |
| postgresql_schema   |
| random_password     |
| null_resource       |

## Usage

You can use this module to create a database and its user inside an RDS cluster

### Example (module)

This example creates a rds-cluster module using a detailed configuration.

```
provider "postgresql" {
  host             = aws_rds_cluster.example.endpoint
  port             = aws_rds_cluster.example.port
  username         = aws_rds_cluster.example.master_username
  password         = aws_rds_cluster.example.master_password
  superuser        = false
  sslmode          = "require"
  expected_version = aws_rds_cluster.example.engine_version_actual
  connect_timeout  = 20
}

module "db_app_1" {
  source = "./../../generic-modules/rds_aurora/postgres_db"

  db_name              = "zytara-app-dev"
  db_username          = "${var.environment}-${var.service_name}"
  db_schema_name       = "zytara-app-dev"
  db_connection_limit  = "5"
  db_statement_timeout = "60000"
  
  rds_cluster_endpoint        = aws_rds_cluster.example.endpoint
  rds_cluster_port            = aws_rds_cluster.example.port
  rds_cluster_master_password = aws_rds_cluster.example.master_password
  rds_cluster_master_username = aws_rds_cluster.example.master_username
  
}
```


## Inputs

| Name                                     | Description                                                                                                        | Type          | Default                  | Required |
|------------------------------------------|--------------------------------------------------------------------------------------------------------------------|---------------|--------------------------|----------|
| db_name                                  | The name of the database. Must be unique on the PostgreSQL server instance where it is configured                  | `string`      | n/a                      | yes      |
| db_username                              | The name of the role. Must be unique on the PostgreSQL server instance where it is configured                      | `string`      | n/a                      | yes      |
| db_schema_name                           | The name of the schema. Must be unique in the PostgreSQL database instance where it is configured                  | `string`      | n/a                      | yes      |
| db_connection_limit                      | If this role can log in, this specifies how many concurrent connections the role can establish                     | `string`      | `10`                     | no       |
| db_statement_timeout                     | Milliseconds. Allows to abort any statement that takes more than the specified amount of time                      | `string`      | `120000`                 | no       |
| rds_cluster_endpoint                     | DNS address of an RDS cluster                                                                                      | `string`      | n/a                      | yes      |
| rds_cluster_port                         | RDS cluster port                                                                                                   | `string`      | `5432`                   | no       |

## Outputs

| Name                                     | Description                                                                                 |
|------------------------------------------|---------------------------------------------------------------------------------------------|
| db_name                                  | The name of the database                                                                    |
| db_username                              | Username of the database user                                                               |
| db_password                              | Database password. Sensitive, not visible in output                                         |
| db_schema_name                           | The name of the schema                                                                      |
