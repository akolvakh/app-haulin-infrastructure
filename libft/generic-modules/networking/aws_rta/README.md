# Route Table Association Terraform Submodule for phoenix #

This Terraform submodule creates the base route table association infrastructure on AWS for phoenix App.

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
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.foo.id
  route_table_id = aws_route_table.bar.id
}
```

```
resource "aws_route_table_association" "b" {
  gateway_id     = aws_internet_gateway.foo.id
  route_table_id = aws_route_table.bar.id
}
```

### Example (module)

This more complete example creates a route table association module using a detailed configuration. Please check the example folder to get the example with all options:

```
module "aws-rta" {
  source = "../networking/aws-rta"

  is_public = true

  # Route table association variables
  rta_route_table_id                      = module.vpc.rt_id
  rta_subnet_id                           = module.subnet.subnets[0].id
  rta_gateway_id                          = module.vpc.internet_gateway_id
}

```



## Inputs

| Name                                         | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | Type          | Default                 | Required |
|----------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|-------------------------|----------|
| app                                          | App name                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | `string`      | "phoenix"                | yes      |
| env                                          | Environment                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `string`      | "dev"                   | yes      |
| is_public                                          |  Boolean variable that decides which resource is public                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | `bool`      | n/a                   | yes      |
| rta_route_table_id                          | The ID of the routing table to associate with                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `string`      | n/a    | yes       |
| rta_subnet_id                          | The subnet ID to create an association. Conflicts with gateway_id                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `string`      | n/a    | no       |
| rta_gateway_id                          | The gateway ID to create an association. Conflicts with subnet_id                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `string`      | n/a    | no       |

## Outputs

| Name                  | Description                                |
|-----------------------|--------------------------------------------|
| id   | The ID of the association |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
