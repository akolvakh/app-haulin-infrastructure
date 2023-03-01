# DB subnet group Terraform Submodule for phoenix #

This Terraform submodule creates the base DB subnet group infrastructure on AWS for phoenix App.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name      | Version |
|-----------|---------|
| terraform | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| aws  | n/a     |

## Resources

| Name |
|------|
|  |
|  |

## Structure
This module consists of next submodules (resources):
1. `submodule`
2. `resource`



## Usage

You can use this module to create a ...

### Example (resources)

This simple example creates a ... :

```
resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [aws_subnet.frontend.id, aws_subnet.backend.id]

  tags = {
    Name = "My DB subnet group"
  }
}
```

### Example (module)

This more complete example creates a db subnet group module using a detailed configuration. Please check the example folder to get the example with all options:

```
*module "db_security_group" {
  source                                  = "../modules/rds_aurora/db-subnet-group"

  # General variables
  app                                     = "phoenix"
  env                                     = var.env

  availability_zones                      = ["/"]

  security_group_name                     = "${var.app}-${var.env}-db-sg-${random_string.suffix.result}"
  security_group_description              = "allow inbound access from the ALB only"
  security_group_vpc_id                   = module.vpc.vpc_id

  # Security group - egress - variables
  egress_from_port                        = 22
  egress_to_port                          = 22
  egress_protocol                         = "tcp"
  egress_cidr_block                       = ["0.0.0.0/0"]
  egress_prefix_list_ids = [""]


  is_ingress                              = true
  ingress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_block  = "1.2.3.4/32"
      description = "all-all"
    },
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
      description = "temp access for configuration"
    },
    {
      from_port   = 23
      to_port     = 23
      protocol    = "tcp"
      cidr_block  = "1.2.3.4/32"
      description = "test"
    }
  ]

  security_group_tags = {
    Name        = "${var.app}-${var.env}-sg-${random_string.suffix.result}"
    Terraform   = true
    App         = var.app
    Environment = "${var.app}-${var.env}"
  }
}
```


## Inputs

| Name                                     | Description                                                                                                                                                                                                                                                                                                                                                                               | Type          | Default                  | Required |
|------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|--------------------------|----------|
| app                                      | App name                                                                                                                                                                                                                                                                                                                                                                                  | `string`      | n/a                | yes      |
| env                                      | Environment                                                                                                                                                                                                                                                                                                                                                                               | `string`      | n/a                      | yes      |
| db_cluster_identifier                    | The cluster identifier. If omitted, Terraform will assign a random, unique identifier                                                                                                                                                                                                                                                                                                     | `string`      | n/a                      | no       |
| db_subnet_group_name                     | A DB subnet group to associate with this DB instance. NOTE: This must match the db_subnet_group_name specified on every aws_rds_cluster_instance in the cluster                                                                                                                                                                                                                           | `string`      | n/a                      | no       |
| subnet_ids                      |IDs of the subnet                                                                                                                                                                                                                                                                                                                                                                                           | `list(any)`        | n/a                  | no       |



## Outputs

| Name                                     | Description                                                                                 |
|------------------------------------------|---------------------------------------------------------------------------------------------|
| db_subnet_group_name                           |Subnet group name of the DB|



<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
