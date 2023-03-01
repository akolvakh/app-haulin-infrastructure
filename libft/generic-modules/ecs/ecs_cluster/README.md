# ECS cluster Terraform Module for phoenix #

This Terraform module creates the base ecs cluster infrastructure on AWS for phoenix App.

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
resource "aws_ecs_cluster" "foo" {
  name = "white-hart"
}
```

### Example (module)

This more complete example creates an ecs cluster module using a detailed configuration. Please check the example folder to get the example with all options:

```
module "ecs_cluster" {
  source                  = "../ecs/ecs_cluster"

  env                     = var.env
}

```


## Inputs

| Name                     | Description                                                                                                                                                      | Type          | Default             | Required |
|--------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|---------------------|----------|
| app                      | App name                                                                                                                                                         | `string`      | "phoenix"            | yes      |
| env                      | Environment                                                                                                                                                      | `string`      | "dev"               | yes      |
| ecs\_name                | The name of the cluster (up to 255 letters, numbers, hyphens, and underscores)                                                                                   | `string`      | "phoenix"            | no      |
| ecs\_capacity\_providers | List of short names of one or more capacity providers to associate with the cluster. Valid values also include FARGATE and FARGATE_SPOT                          | `string`      | "FARGATE"           | no       |
| ecs\_tags                | Key-value map of resource tags                                                                                                                                   | `map(string)` | n/a                 | no       |
| setting\_name            | Name of the setting to manage. Valid values: containerInsights                                                                                                   | `string`      | "containerInsights" | no      |
| setting\_value           | The value to assign to the setting. Value values are enabled and disabled                                                                                        | `string`      | "disabled"          | no      |
| *dcps_capacity\_provider  | The short name of the capacity provider                                                                                                                          | `string`      | "FARGATE"           | no      |
| dcps\_weight             | The relative percentage of the total number of launched tasks that should use the specified capacity provider                                                    | `number`      | n/a                 | no       |
| dcps\_base               | The number of tasks, at a minimum, to run on the specified capacity provider. Only one capacity provider in a capacity provider strategy can have a base defined | `number`      | n/a                 | no       |

## Outputs

| Name                  | Description                 |
|-----------------------|-----------------------------|
| ecs_cluster_id        | ID of the ECS Cluster       |
| ecs_cluster_arn       | ARN of the ECS Cluster      |
| this_ecs_cluster_name | The name of the ECS cluster |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
