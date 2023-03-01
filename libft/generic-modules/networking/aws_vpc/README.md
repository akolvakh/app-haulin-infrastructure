# VPC Terraform Submodule for phoenix #

This Terraform submodule creates the base vpc infrastructure on AWS for phoenix App.

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
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}
```

This simple example creates a route:
```
resource "aws_route" "r" {
  route_table_id            = "rtb-4fbb3ac4"
  destination_cidr_block    = "10.0.1.0/22"
  vpc_peering_connection_id = "pcx-45ff3dc1"
  depends_on                = [aws_route_table.testing]
}
```

Example IPv6 Usage
```
resource "aws_vpc" "vpc" {
  cidr_block                       = "10.1.0.0/16"
  assign_generated_ipv6_cidr_block = true
}

resource "aws_egress_only_internet_gateway" "egress" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "r" {
  route_table_id              = "rtb-4fbb3ac4"
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id      = aws_egress_only_internet_gateway.egress.id
}
```

This simple example creates a route table:
```
resource "aws_route_table" "r" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = aws_internet_gateway.main.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.foo.id
  }

  tags = {
    Name = "main"
  }
}
```


This simple example creates an internet gateway:
```
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}
```

### Example (module)

This more complete example creates a vpc module using a detailed configuration. Please check the example folder to get the example with all options:

```
module "vpc" {
  source = "../networking/aws-vpc"

  # General variables
  env                                     = var.env

  # VPC variables
  vpc_cidr_block                          = var.vpc_cidr_block
  vpc_block_part                          = var.vpc_block_part

  # Route variables
  route_destination_ipv6_cidr_block       = "d1"
  route_egress_only_gateway_id            = "d0"
  route_gateway_id                        = "d6"
  route_instance_id                       = "d2"
  route_nat_gateway_id                    = "d3"
  route_local_gateway_id                  = "d7"
  route_network_interface_id              = "d4"
  route_transit_gateway_id                = "d8"
  route_vpc_endpoint_id                   = "d9"
  route_vpc_peering_connection_id         = "d5"

}
```



## Inputs

| Name                                         | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | Type          | Default                 | Required |
|----------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|-------------------------|----------|
| app                                          | App name                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | `string`      | "phoenix"                | yes      |
| env                                          | Environment                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `string`      | "dev"                   | yes      |
| availability_zones                             | List of availability zones to be used by subnets                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | `list(any)`      |n/a| yes      |
| the_id                                          | Environment                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `string`      | n/a                   | yes      |
| is_public                                          |  Boolean variable that decides which resource is public                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | `bool`      | `true`                   | yes      |
| vpc\_cidr\_block                             | The CIDR block for the VPC                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | `string`      | "10.0.0.0/16"           | yes      |
| vpc_block_part                             | The block part for the VPC                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | `string`      | n/a           | yes      |
| vpc\_instance\_tenancy                       | A tenancy option for instances launched into the VPC. Default is default, which makes your instances shared on the host. Using either of the other options (dedicated or host) costs at least $2/hr                                                                                                                                                                                                                                                                                                                                                               | `string`      | "default"               | yes      |
| vpc\_enable\_dns_support                     | A boolean flag to enable/disable DNS support in the VPC                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | `bool`        | `true`                  | no       |
| vpc\_enable\_dns\_hostnames                  | A boolean flag to enable/disable DNS hostnames in the VPC                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | `bool`        | `false`                 | no       |
| vpc\_enable\_classiclink                     | A boolean flag to enable/disable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic. See the ClassicLink documentation for more information                                                                                                                                                                                                                                                                                                                                                                                     | `bool`        | `false`                 | no       |
| vpc\_enable\_classiclink\_dns\_support       | A boolean flag to enable/disable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic                                                                                                                                                                                                                                                                                                                                                                                                                                 | `bool`        | `false`                 | no       |
| vpc\_assign\_generated\_ipv6\_cidr\_block    | Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block                                                                                                                                                                                                                                                                                                                                                                                                     | `bool`        | `false`                 | no       |
| vpc\_tags                                    | A map of tags to assign to the resource                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | `map(string)` | n/a                     | no       |
| route_destination_cidr_block                          | The destination CIDR block                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `string`      | "0.0.0.0/0"    | no       |
| route_destination_ipv6_cidr_block                          | The destination IPv6 CIDR block                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `string`      |n/a| no       |
| route_egress_only_gateway_id                          | Identifier of a VPC Egress Only Internet Gateway                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `string`      |n/a| no       |
| route_gateway_id                          | Identifier of a VPC internet gateway or a virtual private gateway                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `string`      |n/a| no       |
| route_instance_id                          | Identifier of an EC2 instance                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `string`      |n/a| no       |
| route_nat_gateway_id                          | Identifier of a VPC NAT gateway                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `string`      |n/a| no       |
| route_local_gateway_id                          | Identifier of a Outpost local gateway                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `string`      |n/a| no       |
| route_network_interface_id                          | Identifier of an EC2 network interface                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `string`      |n/a| no       |
| route_transit_gateway_id                          | Identifier of an EC2 Transit Gateway                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `string`      |n/a| no       |
| route_vpc_endpoint_id                          | Identifier of a VPC Endpoint                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `string`      |n/a| no       |
| route_vpc_peering_connection_id                          | Identifier of a VPC peering connection                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `string`      |n/a| no       |
| ig_tags                          | A map of tags to assign to the resource                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `map(string)`      |n/a| no       |

## Outputs

| Name                  | Description                                |
|-----------------------|--------------------------------------------|
| vpc\_id               | The ID of the VPC                          |
| vpc\_cidr\_block      | The CIDR block of the VPC                  |
| internet_gateway_id  | ID of the generated Internet Gateway           |
| private_rt_id         | The private route table ID                 |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
