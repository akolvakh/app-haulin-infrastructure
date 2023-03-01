# Application Load Balancer Terraform Module for phoenix #

This Terraform module creates the base application load balancer infrastructure on AWS for phoenix App.

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

## Structure
This module consists of next submodules:
1. `sg`
2. `main (alb)`


## Usage

You can use this module to create a ...

### Example (resources)

This simple example creates a ... :

```

```


Application Load Balancer
```
resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = aws_subnet.public.*.id

  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.lb_logs.bucket
    prefix  = "test-lb"
    enabled = true
  }

  tags = {
    Environment = "production"
  }
}
```

Network Load Balancer
```
resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "network"
  subnets            = aws_subnet.public.*.id

  enable_deletion_protection = true

  tags = {
    Environment = "production"
  }
}
```

Specifying Elastic IPs
```
resource "aws_lb" "example" {
  name               = "example"
  load_balancer_type = "network"

  subnet_mapping {
    subnet_id     = aws_subnet.example1.id
    allocation_id = aws_eip.example1.id
  }

  subnet_mapping {
    subnet_id     = aws_subnet.example2.id
    allocation_id = aws_eip.example2.id
  }
}
```

Specifying private IP addresses for an internal-facing load balancer
```
resource "aws_lb" "example" {
  name               = "example"
  load_balancer_type = "network"

  subnet_mapping {
    subnet_id            = aws_subnet.example1.id
    private_ipv4_address = "10.0.1.15"
  }

  subnet_mapping {
    subnet_id            = aws_subnet.example2.id
    private_ipv4_address = "10.0.2.15"
  }
}
```


### Example (module)

This more complete example creates an application load balancer module using a detailed configuration. Please check the example folder to get the example with all options:

```
module "alb" {
  source              = "../elb/alb"

  app                 = "phoenix"
  env                 = var.env
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = module.subnet.subnets[*].id
  alb_name            = "phoenix-alb"
  alb_name_prefix     = "phoenix-pefix"
  access_logs_bucket  = "alb/logs"
  sm_subnet_id        = "some_id"
}

```

## Inputs

| Name                                 | Description                                                                                                                                                                                                                                                                                                                    | Type          | Default       | Required |
|--------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|---------------|----------|
| app                                  | App name                                                                                                                                                                                                                                                                                                                       | `string`      | "phoenix"      | yes      |
| env                                  | Environment                                                                                                                                                                                                                                                                                                                    | `string`      | "dev"         | yes      |
| vpc_id                               | ID of the VPC                                                                                                                                                                                                                                                                                                                  | `string`      | n/a           | yes      |
| subnet_ids                           | IDs of the subnet                                                                                                                                                                                                                                                                                                              | `list(any)`   | n/a           | yes      |
| alb_name                             | The name of the LB. This name must be unique within your AWS account, can have a maximum of 32 characters, must contain only alphanumeric characters or hyphens, and must not begin or end with a hyphen. If not specified, Terraform will autogenerate a name beginning with tf-lb                                            | `string`      | n/a           | no       |
| alb_name_prefix                      | Creates a unique name beginning with the specified prefix. Conflicts with name                                                                                                                                                                                                                                                 | `string`      | n/a           | no       |
| alb_internal                         | If true, the LB will be internal                                                                                                                                                                                                                                                                                               | `bool`        | `false`       | no       |
| alb_load_balancer_type               | The type of load balancer to create. Possible values are application, gateway, or network. The default value is application                                                                                                                                                                                                    | `string`      | "application" | no       |
| alb_security_groups                  | A list of security group IDs to assign to the LB. Only valid for Load Balancers of type application                                                                                                                                                                                                                            | `list(string)`   | n/a           | no       |
| alb_drop_invalid_header_fields       | Indicates whether HTTP headers with header fields that are not valid are removed by the load balancer (true) or routed to targets (false). The default is false. Elastic Load Balancing requires that message header names contain only alphanumeric characters and hyphens. Only valid for Load Balancers of type application | `bool`        | `true`        | no       |
|                                      |                                                                                                                                                                                                                                                                                                                                | ``            | n/a           | no       |
| *alb_subnets                         | A list of subnet IDs to attach to the LB. Subnets cannot be updated for Load Balancers of type network. Changing this value for load balancers of type network will force a recreation of the resource                                                                                                                         | `list(any)`   | n/a           | no       |
|                                      |                                                                                                                                                                                                                                                                                                                                | ``            | n/a           | no       |
| alb_idle_timeout                     | The time in seconds that the connection is allowed to be idle. Only valid for Load Balancers of type application. Default: 60                                                                                                                                                                                                  | `number`      | 60            | no       |
| alb_enable_deletion_protection       | If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false                                                                                                                                                                        | `bool`        | `false`       | no       |
| alb_enable_cross_zone_load_balancing | If true, cross-zone load balancing of the load balancer will be enabled. This is a network load balancer feature. Defaults to false                                                                                                                                                                                            | `bool`        | false         | no       |
| alb_enable_http2                     | (Optional) Indicates whether HTTP/2 is enabled in application load balancers. Defaults to true                                                                                                                                                                                                                                 | `bool`        | `true`        | no       |
| alb_customer_owned_ipv4_pool         | (Optional) The ID of the customer owned ipv4 pool to use for this load balancer                                                                                                                                                                                                                                                | `string`      | n/a           | no       |
| alb_ip_address_type                  | (Optional) The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack                                                                                                                                                                                                     | `string`      | "ipv4"        | no       |
| alb_tags                             | A map of tags to assign to the resource                                                                                                                                                                                                                                                                                        | `map(string)` | n/a           | no       |
| access_logs_bucket                   | The S3 bucket name to store the logs in                                                                                                                                                                                                                                                                                        | `string`      | n/a           | yes      |
| access_logs_prefix                   | The S3 bucket prefix. Logs are stored in the root if not configured                                                                                                                                                                                                                                                            | `string`      | n/a           | no       |
| access_logs_enabled                  | Boolean to enable / disable access_logs. Defaults to false, even when bucket is specified                                                                                                                                                                                                                                      | `bool`        | `false`       | no       |
| sm_subnet_id                         | The id of the subnet of which to attach to the load balancer. You can specify only one subnet per Availability Zone                                                                                                                                                                                                            | `string`      | n/a           | yes      |
| sm_allocation_id                     | The allocation ID of the Elastic IP address                                                                                                                                                                                                                                                                                    | `string`      | n/a           | no       |
| sm_private_ipv4_address              | A private ipv4 address within the subnet to assign to the internal-facing load balancer                                                                                                                                                                                                                                        | `string`      | n/a           | no       |
| sm_ipv6_address                      | An ipv6 address within the subnet to assign to the internet-facing load balancer                                                                                                                                                                                                                                               | `string`      | n/a           | no       |



## Outputs

| Name                          | Description                                                                               |
|-------------------------------|-------------------------------------------------------------------------------------------|
| alb_id                        | The ARN of the load balancer (matches arn)                                                |
| alb_arn                       | The ARN of the load balancer (matches id)                                                 |
| alb_arn_suffix                | The ARN suffix for use with CloudWatch Metrics                                            |
| alb_dns_name                  | The DNS name of the load balancer                                                         |
| alb_zone_id                   | The canonical hosted zone ID of the load balancer (to be used in a Route 53 Alias record) |
| alb_subnet_mapping_outpost_id | ID of the Outpost containing the load balancer                                            |
| *ecs_be_sg                    |                                                                                           |
| ecs_be_security_group         | Security group of the ECS backend                                                         |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
