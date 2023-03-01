# ECS service Terraform Module for phoenix #

This Terraform module creates the base ecs service infrastructure on AWS for phoenix App.

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
resource "aws_ecs_service" "mongo" {
  name            = "mongodb"
  cluster         = aws_ecs_cluster.foo.id
  task_definition = aws_ecs_task_definition.mongo.arn
  desired_count   = 3
  iam_role        = aws_iam_role.foo.arn
  depends_on      = [aws_iam_role_policy.foo]

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.foo.arn
    container_name   = "mongo"
    container_port   = 8080
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  }
}
```

Ignoring Changes to Desired Count
```
resource "aws_ecs_service" "example" {
  # ... other configurations ...

  # Example: Create service with 2 instances to start
  desired_count = 2

  # Optional: Allow external changes without Terraform plan difference
  lifecycle {
    ignore_changes = [desired_count]
  }
}
```
Daemon Scheduling Strategy
```
resource "aws_ecs_service" "bar" {
  name                = "bar"
  cluster             = aws_ecs_cluster.foo.id
  task_definition     = aws_ecs_task_definition.bar.arn
  scheduling_strategy = "DAEMON"
}
```

External Deployment Controller
```
resource "aws_ecs_service" "example" {
  name    = "example"
  cluster = aws_ecs_cluster.example.id

  deployment_controller {
    type = "EXTERNAL"
  }
}
```


### Example (module)

This more complete example creates an ecs service module using a detailed configuration. Please check the example folder to get the example with all options:

```
module "ecs_service" {
  source                                                  = "../ecs/ecs_service"

  # General variables
  app                                                     = "phoenix"
  env                                                     = "dev"
  region                                                  = "us-east-1"
  healthcheck_path                                        = var.healthcheck_path

  aws_ecs_task_definition_arn                             = module.ecs_task_definition.task_def_arn
  aws_iam_role_policy_attachment_ecs_task_execution_role  = module.td-execution-role
  aws_lb_listener_http_forward                            = module.alb
  aws_lb_target_group_arn                                 = module.lb-target-group.target_group_arn
  ecs_cluster_id                                          = module.ecs_cluster.ecs_cluster_id
  ecs_sg                                                  = module.sg-ecs_be.security_group_id
  subnet_ids                                              = module.subnet.*.public_subnets_ids[0]
}
```


## Inputs

| Name                               | Description                                                                                                                                                                                                                                                                                                                   | Type          | Default         | Required |
|------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|-----------------|----------|
| app                                | App name                                                                                                                                                                                                                                                                                                                      | `string`      | "sytara"        | yes      |
| env                                | Environment                                                                                                                                                                                                                                                                                                                   | `string`      | "dev"           | yes      |
| region                             |                              Region                                                                                                                                                                                                                                                                                                 | `string`            | n/a             | yes       |
| healthcheck_path                   |                                  Path of the healthcheck                                                                                                                                                                                                                                                                                             | `string`            | n/a             | yes       |
| subnet_ids                         |                IDs of the subnets                                                                                                                                                                                                                                                                                                                | `list(any)`            | n/a             | yes       |
| ecs_cluster_id                     |                ID of the ECS cluster                                                                                                                                                                                                                                                                                                               | `string`            | n/a             | yes       |
| ecs_sg                             |                       Security group of the ECS                                                                                                                                                                                                                                                                                                        | `string`            | n/a             | yes       |
| aws_ecs_task_definition_arn                            |The family and revision (family:revision) or full ARN of the task definition that you want to run in your service. Required unless using the EXTERNAL deployment controller. If a revision is not specified, the latest ACTIVE revision is used| `string`            |"/"| no       |
| aws_lb_target_group_arn                            |The ARN of the Load Balancer target group to associate with the service| `string`            | n/a             | yes       |
| aws_lb_listener_http_forward                            |AWS load balancer listener| `string`            |"/"| no       |
| aws_iam_role_policy_attachment_ecs_task_execution_role                            |AWS IAM role policy attachment for ecs task execution role| `string`            |"/"| no       |


## Outputs

| Name              | Description                                     |
|-------------------|-------------------------------------------------|
| ecs_service_id      |The Amazon Resource Name (ARN) that identifies the service|
|ecs_service_name|The name of the service|
|ecs_service_cluster| The Amazon Resource Name (ARN) of cluster which the service runs on |
|ecs_service_iam_role|The ARN of IAM role used for ELB|
|ecs_service_desired_count|The number of instances of the task definition|

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
