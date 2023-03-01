# Security group Terraform Submodule for phoenix #

This Terraform submodule creates the base security group infrastructure on AWS for phoenix App.

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
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
```

This simple example creates a security group rule:

```
resource "aws_security_group_rule" "example" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = "sg-123456"
}
```

### Example (module)

This more complete example creates a security group module using a detailed configuration. Please check the example folder to get the example with all options:

```
module "sg-main" {
  source                                  = "../networking/aws-sg"

  is_ingress                              = false
  ingress_rules                           = []
  app                                     = "phoenix"
  env                                     = "dev"

  availability_zones                      = ["use1-az1", "use1-az2", "use1-az3", "use1-az4", "use1-az5", "use1-az6"]

  security_group_vpc_id                   = module.vpc.vpc_id
  security_group_name                     = "alb-public"
  security_group_description              = "controls access to the Application Load Balancer (ALB)"

  ingress_from_port                       = 80
  ingress_to_port                         = 80
  ingress_protocol                        = "tcp"
  ingress_cidr_block                      = ["0.0.0.0/0"]

  egress_from_port                        = 0
  egress_to_port                          = 0
  egress_protocol                         = "-1"
  egress_cidr_block                       = ["0.0.0.0/0"]
  egress_prefix_list_ids = [""]

  security_group_tags = {
    Name        = "${var.app}-${var.env}-sg-${random_string.suffix.result}"
    Terraform   = true
    App         = var.app
    Environment = "${var.app}-${var.env}"
  }
}

```


## Inputs

| Name                                         | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | Type          | Default                 | Required |
|----------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|-------------------------|----------|
| app                                          | App name                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | `string`      | "phoenix"                | yes      |
| env                                          | Environment                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `string`      | "dev"                   | yes      |
| is_ingress                                          |  Boolean variable that decides switch ingress on or off                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | `bool`      | n/a                   | yes      |
| *ingress_rules                                          |  Ingress rules                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | `list(object({})`      | n/a                   | no      |
| security\_group\_tags                        | A map of tags to assign to the resource                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | `map(string)` | n/a                     | no       |
| security_group_vpc_id                        | The ID of the VPC                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | `string` | n/a                     | yes       |
| security\_group\_name                        | The name of the security group. If omitted, Terraform will assign a random, unique name                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | `string`      | "phoenix-security-group" | no       |
| security\_group\_name\_prefix                | Creates a unique name beginning with the specified prefix. Conflicts with name                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | `string`      | "zt"                    | no       |
| security\_group\_description                 | The security group description. Defaults to 'Managed by Terraform'. Cannot be empty. NOTE: This field maps to the AWS GroupDescription attribute, for which there is no Update API. If you'd like to classify your security groups in a way that can be updated, use tags                                                                                                                                                                                                                                                                                         | `string`      | "default description"   | no       |
| security\_group\_revoke\_rules\_on\_delete   | Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself. This is normally not needed, however certain AWS services such as Elastic Map Reduce may automatically add required rules to security groups used with the service, and those rules may contain a cyclic dependency that prevent the security groups from being destroyed without removing the dependency first                                                                                                                        | `bool`        | `false`                 | no       |
| ingress\_from\_port                          | The start port (or ICMP type number if protocol is 'icmp' or 'icmpv6')                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | `number`      | 22                      | yes      |
| ingress\_to\_port                            | The end range port (or ICMP code if protocol is 'icmp')                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | `number`      | 22                      | yes      |
| ingress\_protocol                            | The protocol. If you select a protocol of '-1' (semantically equivalent to 'all', which is not a valid value here), you must specify a 'from_port' and 'to_port' equal to 0. The supported values are defined in the 'IpProtocol' argument on the IpPermission API reference. This argument is normalized to a lowercase value to match the AWS API requirement when using with Terraform 0.12.x and above, please make sure that the value of the protocol is specified as lowercase when using with older version of Terraform to avoid an issue during upgrade | `string`      | "tcp"                   | yes      |
| ingress\_cidr\_block                         | List of CIDR blocks                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | `list(any)`   | n/a                     | no       |
| ingress\_ipv6\_cidr\_blocks                  | List of IPv6 CIDR blocks                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | `list(any)`   | n/a                     | no       |
| ingress\_prefix\_list\_ids                   | List of Prefix List IDs                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | `list(any)`   | n/a                     | no       |
| ingress\_security\_groups                    | List of security group Group Names if using EC2-Classic, or Group IDs if using a VPC                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | `list(any)`   | n/a                     | no       |
| ingress\_self                                | If true, the security group itself will be added as a source to this ingress rule                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | `bool`        | `false`                 | no       |
| ingress\_description                         | Description of this ingress rule                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | `string`      | "ingress description"   | no       |
| egress\_from\_port                           | The start port (or ICMP type number if protocol is 'icmp' or 'icmpv6')                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | `number`      | 22                      | yes      |
| egress\_to\_port                             | The end range port (or ICMP code if protocol is 'icmp')                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | `number`      | 22                      | yes      |
| egress\_protocol                             | The protocol. If you select a protocol of '-1' (semantically equivalent to 'all', which is not a valid value here), you must specify a 'from_port' and 'to_port' equal to 0. The supported values are defined in the 'IpProtocol' argument on the IpPermission API reference. This argument is normalized to a lowercase value to match the AWS API requirement when using with Terraform 0.12.x and above, please make sure that the value of the protocol is specified as lowercase when using with older version of Terraform to avoid an issue during upgrade | `string`      | "n/a                  | yes      |
| egress\_cidr\_block                          | List of CIDR blocks                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | `list(any)`   | n/a                     | no       |
| egress\_ipv6\_cidr\_blocks                   | List of IPv6 CIDR blocks                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | `list(any)`   | n/a                     | no       |
| egress\_prefix\_list\_ids                    | List of Prefix List IDs                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | `list(any)`   | n/a                     | no       |
| egress\_security\_groups                     | List of security group Group Names if using EC2-Classic, or Group IDs if using a VPC                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | `list(any)`   | n/a                     | no       |
| egress\_self                                 | If true, the security group itself will be added as a source to this egress rule                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | `bool`        | `false`                 | no       |
| egress\_description                          | Description of this egress rule                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `string`      | "egress description"    | no       |
| security_group_vpc_id                          | Description of this egress rule                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `string`      | n/a    | yes       |

## Outputs

| Name                  | Description                                |
|-----------------------|--------------------------------------------|
| security_group_id               | The ID of the security group                          |
| security_group_arn      | The ARN of the security group                  |
| security_group_name   | The name of the security group |
| security_group_ingress | The ingress rules          |
| security_group_egress  | The egress rules           |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
