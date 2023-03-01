# NAT Gateway Terraform Submodule for phoenix #

This Terraform submodule creates the base nat gateway infrastructure on AWS for phoenix App.

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
resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.example.id

  tags = {
    Name = "gw NAT"
  }
}
```

### Example (module)

This more complete example creates a nat gateway module using a detailed configuration. Please check the example folder to get the example with all options:

```
module "nat-gateway" {
  source          = "../networking/aws-nat-gateway"

  app             = "phoenix"
  env             = "dev"
  allocation_id   = "some_id"
  subnet_id       = "some_id"
}
```



## Inputs

| Name                                         | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | Type          | Default                 | Required |
|----------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|-------------------------|----------|
| app                                          | App name                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | `string`      | "phoenix"                | yes      |
| env                                          | Environment                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `string`      | "dev"                   | yes      |
| allocation_id                                          | The Allocation ID of the Elastic IP address for the gateway                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `string`      |n/a| yes      |
| subnet_id                                          | The Subnet ID of the subnet in which to place the gateway                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `string`      |n/a| yes      |
| tags                                          | A map of tags to assign to the resource                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `map(string)`      | n/a                   | no      |

## Outputs

| Name                  | Description                                |
|-----------------------|--------------------------------------------|
| id               | The ID of the NAT Gateway                          |
| allocation_id      | The Allocation ID of the Elastic IP address for the gateway                  |
| subnet_id   | The Subnet ID of the subnet in which the NAT gateway is placed |
| network_interface_id | The ENI ID of the network interface created by the NAT gateway          |
| private_ip  | The private IP address of the NAT Gateway           |
| public_ip  | The public IP address of the NAT Gateway           |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
