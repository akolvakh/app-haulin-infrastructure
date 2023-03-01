# Subnet Terraform Submodule for phoenix #

This Terraform submodule creates the base subnet infrastructure on AWS for phoenix App.

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
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }
}
```


Subnets In Secondary VPC CIDR Blocks
```
resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "172.2.0.0/16"
}

resource "aws_subnet" "in_secondary_cidr" {
  vpc_id     = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id
  cidr_block = "172.2.0.0/24"
}
```

### Example (module)

This more complete example creates a subnet module using a detailed configuration. Please check the example folder to get the example with all options:

```
module "subnet" {
  source = "../networking/aws-subnet"

  # General variables
  is_public                               = true
  env                                     = var.env
  availability_zones                      = data.aws_availability_zones.available.names
  subnet_availability_zones_id            = ["use1-az1", "use1-az2", "use1-az3", "use1-az4", "use1-az5", "use1-az6"]

  # Subnet variables
  subnet_vpc_id                           = module.vpc.vpc_id
  *subnet_cidr_block                       = ["10.0.0.0/16"]
  vpc_block_part                          = var.vpc_block_part


  #
  subnet_customer_owned_ipv4_pool         = "d18"
  subnet_ipv6_cidr_block                  = "2001:db8:1234:1a00::/64"
  subnet_outpost_arn                      = "arn:aws:iam::123456789012:user/Development/product_12345/*"

}

```




## Inputs

| Name                                         | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | Type          | Default                 | Required |
|----------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|-------------------------|----------|
| app                                          | App name                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | `string`      | "phoenix"                | yes      |
| env                                          | Environment                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `string`      | "dev"                   | yes      |
| availability_zones                             | List of availability zones to be used by subnets                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | `list(any)`      |n/a| yes      |
| the_id                                          | The id of the subnet                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `string`      | n/a                   | yes      |
| is_public                                          |  Boolean variable that decides which resource is public                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | `bool`      | n/a                   | yes      |
| subnet_vpc_id                          | The ID of the VPC                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | `string`      | n/a                     | yes      |
| subnet\_cidr\_block                          | The CIDR block for the subnet                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | `string`      | n/a                     | yes      |
| subnet\_availability\_zones                  | The AZ for the subnet                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | `list(any)`   | n/a                     | no       |
| subnet\_availability\_zones\_id              | The AZ for the subnet                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | `list(any)`   | n/a                     | no       |
| subnet\_customer\_owned\_ipv4\_pool          | The customer owned IPv4 address pool. Typically used with the map_customer_owned_ip_on_launch argument. The outpost_arn argument must be specified when configured                                                                                                                                                                                                                                                                                                                                                                                                | `string`      | n/a                     | no       |
| subnet\_ipv6\_cidr\_block                    | The IPv6 network range for the subnet, in CIDR notation. The subnet size must use a /64 prefix length                                                                                                                                                                                                                                                                                                                                                                                                                                                             | `string`      | n/a                     | no       |
| subnet\_map\_customer\_owned\_ip\_on\_launch | Specify true to indicate that network interfaces created in the subnet should be assigned a customer owned IP address. The customer_owned_ipv4_pool and outpost_arn arguments must be specified when set to true                                                                                                                                                                                                                                                                                                                                                  | `bool`        | `false`                 | no       |
| subnet\_map\_public\_ip\_on\_launch          | Specify true to indicate that instances launched into the subnet should be assigned a public IP address                                                                                                                                                                                                                                                                                                                                                                                                                                                           | `bool`        | `false`                 | no       |
| subnet\_outpost\_arn                         | The Amazon Resource Name (ARN) of the Outpost                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | `string`      | n/a                     | no       |
| subnet\_assign\_ipv6\_address\_on\_creation  | Specify true to indicate that network interfaces created in the specified subnet should be assigned an IPv6 address                                                                                                                                                                                                                                                                                                                                                                                                                                               | `bool`        | `false`                 | no       |
| subnet\_tags                                 | A map of tags to assign to the resource                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | `map(string)` | n/a                     | no       |
| rta_route_table_id                          | The ID of the routing table to associate with                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `string`      | n/a    | yes       |
| rta_subnet_id                          | The subnet ID to create an association. Conflicts with gateway_id                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `string`      | n/a    | no       |
| rta_gateway_id                          | The gateway ID to create an association. Conflicts with subnet_id                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `string`      | n/a    | no       |
| subnet_vpc_id                          | The gateway ID to create an association. Conflicts with subnet_id                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `string`      | n/a    | no       |

## Outputs

| Name                  | Description                                |
|-----------------------|--------------------------------------------|
| availability\_zones   | List of availability zones used by subnets |
| private\_subnets\_ids | List with the Private Subnets IDs          |
| public\_subnets\_ids  | List with the Public Subnets IDs           |
| subnets  | List with the Public Subnets IDs           |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
