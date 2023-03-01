# LB Target Group Terraform Module for phoenix #

This Terraform module creates the base lb target group infrastructure on AWS for phoenix App.

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

```


Instance Target Group
```
resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}
```

IP Target Group
```
resource "aws_lb_target_group" "ip-example" {
  name        = "tf-example-lb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.main.id
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}
```

Lambda Target Group
```
resource "aws_lb_target_group" "lambda-example" {
  name        = "tf-example-lb-tg"
  target_type = "lambda"
}
```

### Example (module)

This more complete example creates a lb target group module using a detailed configuration. Please check the example folder to get the example with all options:

```
module "lb-target-group" {
  source = "../elb/aws_lb_target_group"

  app               = "phoenix"
  env               = "dev"
  healthcheck_path  = var.healthcheck_path
  vpc_id            = module.vpc.vpc_id
}

```


## Inputs

| Name                               | Description                                                                                                                                                                                                                                                                                                                   | Type          | Default         | Required |
|------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|-----------------|----------|
| app                                | App name                                                                                                                                                                                                                                                                                                                      | `string`      | "sytara"        | yes      |
| env                                | Environment                                                                                                                                                                                                                                                                                                                   | `string`      | "dev"           | yes      |
| healthcheck_path                   |                                  Path of the healthcheck                                                                                                                                                                                                                                                                                             | `string`            | n/a             | yes       |
| vpc_id                         |ID of the VPC| `string`            | n/a             | yes       |


## Outputs

| Name              | Description                                     |
|-------------------|-------------------------------------------------|
|target_group_id|The ARN of the Target Group (matches arn)|
|target_group_arn|The ARN of the Target Group (matches id)|
|target_group_arn_suffix|The ARN suffix for use with CloudWatch Metrics|
|target_group_name|The name of the Target Group|

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
