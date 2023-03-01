# LB Listener Terraform Module for phoenix #

This Terraform module creates the base lb listener infrastructure on AWS for phoenix App.

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

## Usage

You can use this module to create a ...

### Example (resources)

This simple example creates a ... :

```

```


Forward Action
```
resource "aws_lb" "front_end" {
  # ...
}

resource "aws_lb_target_group" "front_end" {
  # ...
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.front_end.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
}
```

Redirect Action
```
resource "aws_lb" "front_end" {
  # ...
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.front_end.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
```

Fixed-response Action
```
resource "aws_lb" "front_end" {
  # ...
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.front_end.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content"
      status_code  = "200"
    }
  }
}
```

Authenticate-cognito Action
```
resource "aws_lb" "front_end" {
  # ...
}

resource "aws_lb_target_group" "front_end" {
  # ...
}

resource "aws_cognito_user_pool" "pool" {
  # ...
}

resource "aws_cognito_user_pool_client" "client" {
  # ...
}

resource "aws_cognito_user_pool_domain" "domain" {
  # ...
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.front_end.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "authenticate-cognito"

    authenticate_cognito {
      user_pool_arn       = aws_cognito_user_pool.pool.arn
      user_pool_client_id = aws_cognito_user_pool_client.client.id
      user_pool_domain    = aws_cognito_user_pool_domain.domain.domain
    }
  }

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
}
```

Authenticate-oidc Action
```
resource "aws_lb" "front_end" {
  # ...
}

resource "aws_lb_target_group" "front_end" {
  # ...
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.front_end.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "authenticate-oidc"

    authenticate_oidc {
      authorization_endpoint = "https://example.com/authorization_endpoint"
      client_id              = "client_id"
      client_secret          = "client_secret"
      issuer                 = "https://example.com"
      token_endpoint         = "https://example.com/token_endpoint"
      user_info_endpoint     = "https://example.com/user_info_endpoint"
    }
  }

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
}
```

Gateway Load Balancer Listener
```
resource "aws_lb" "example" {
  load_balancer_type = "gateway"
  name               = "example"

  subnet_mapping {
    subnet_id = aws_subnet.example.id
  }
}

resource "aws_lb_target_group" "example" {
  name     = "example"
  port     = 6081
  protocol = "GENEVE"
  vpc_id   = aws_vpc.example.id

  health_check {
    port     = 80
    protocol = "HTTP"
  }
}

resource "aws_lb_listener" "example" {
  load_balancer_arn = aws_lb.example.id

  default_action {
    target_group_arn = aws_lb_target_group.example.id
    type             = "forward"
  }
}
```

### Example (module)

This more complete example creates a lb listener module using a detailed configuration. Please check the example folder to get the example with all options:

```
module "lb-listener" {
  source = "../elb/aws_lb_listener"

  app                           = "phoenix"
  env                           = "dev"
  alb_arn                       = module.alb.alb_arn
  aws_lb_target_group_main_arn  = module.lb-target-group.target_group_arn
}

```


## Inputs

| Name                                 | Description                                                                                                                                                                                                                                                                                                                    | Type          | Default       | Required |
|--------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|---------------|----------|
| app                                  | App name                                                                                                                                                                                                                                                                                                                       | `string`      | "phoenix"      | yes      |
| env                                  | Environment                                                                                                                                                                                                                                                                                                                    | `string`      | "dev"         | yes      |
| alb_arn                               | The ARN of the load balancer                                                                                                                                                                                                                                                                                                                  | `string`      | n/a           | yes      |
| aws_lb_target_group_main_arn                           |The ARN of the Target Group to which to route traffic. Specify only if type is forward and you want to route to a single target group. To route to one or more target groups, use a forward block instead| `string`   | "/"           | no      |


## Outputs

| Name                          | Description                                                                               |
|-------------------------------|-------------------------------------------------------------------------------------------|
| lb_listener_id                        |The ARN of the Target Group (matches arn)|
|lb_listener_arn|The ARN of the Target Group (matches id)|

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
