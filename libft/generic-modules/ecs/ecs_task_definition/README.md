# ECS Task Definition Terraform Module for phoenix #

This Terraform module creates the base ecs task definition infrastructure on AWS for phoenix App.

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
resource "aws_ecs_task_definition" "service" {
  family                = "service"
  container_definitions = file("task-definitions/service.json")

  volume {
    name      = "service-storage"
    host_path = "/ecs/service-storage"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  }
}
```

With AppMesh Proxy
```
resource "aws_ecs_task_definition" "service" {
  family                = "service"
  container_definitions = file("task-definitions/service.json")

  proxy_configuration {
    type           = "APPMESH"
    container_name = "applicationContainerName"
    properties = {
      AppPorts         = "8080"
      EgressIgnoredIPs = "169.254.170.2,169.254.169.254"
      IgnoredUID       = "1337"
      ProxyEgressPort  = 15001
      ProxyIngressPort = 15000
    }
  }
}
```

### Example (module)

This more complete example creates an ecs task definition module using a detailed configuration. Please check the example folder to get the example with all options:

```
module "ecs_task_definition" {
  source                                = "../ecs/ecs_task_definition"

  # General variables
  app                                   = "phoenix"
  env                                   = var.env
  region                                = var.region
  healthcheck_path                      = var.healthcheck_path

  # VPC variables
  vpc_id                                = module.vpc.vpc_id

  # Subnet variables
  subnet_ids                            = module.subnet.*.public_subnets_ids

  # ECR variables
  ecr_id                                = module.ecr_be.ecr_registry_id
  ecr_url                               = module.ecr_be.ecr_repository_url
  ecr_image_tag                         = var.ecr_image_tag

  # ECS variables
  ecs_cluster_id                        = module.ecs_cluster.ecs_cluster_id
  ecs_sg                                = module.sg-ecs_be.security_group_id

  # AWS ECS Task Definition variables (top-level)
  td_family                             = "service"
  td_cpu                                = var.ecs_task_cpu
  td_memory                             = var.ecs_task_memory
  td_network_mode                       = "awsvpc"
  td_execution_role_arn                 =  module.td-execution-role.arn
  td_task_role_arn                      = "arn:aws:iam::123456789012:user/Development/product_1234/*"
  td_container_definitions              = <<DEFINITION
[
   {
     "name": "phoenix-be-dev",
     "image": "public.ecr.aws/nginx/nginx:latest",
     "memory": 256,
     "cpu": 256,
     "essential": true,
     "portMappings": [
       {
        "containerPort": 8080,
        "hostPort": 8080,
        "protocol": "tcp"
       }
     ],
     "logConfiguration": {
         "logDriver": "awslogs",
         "options": {
             "awslogs-group": "awslogs-nginx-ecs",
             "awslogs-region": "us-east-1",
             "awslogs-stream-prefix": "nginx"
         }
     }
   }
]
DEFINITION



  # Volume Block variables
  volume_name                           = ""
  volume_host_path                      = "phoenix-default-0"

  # Inference Accelerators variables
  inference_accelerators_device_name    = "phoenix-default-1"
  inference_accelerators_device_type    = "phoenix-default-9"

  # EFS Volume Configuration variables
  efs_file_system_id                    = "phoenix-default-2"
  efs_root_directory                    = "phoenix-default-3"
  efs_transit_encryption_port           = "phoenix-default-4"
  efs_authorization_access_point_id     = "phoenix-default-5"

  # Docker Volume Configuration variables
  dvc_driver                            = "phoenix-default-6"

  # Placement Constraints variables
  placement_constraints_type            = "phoenix-default-7"
  placement_constraints_expression      = "phoenix-default-8"

  # Proxy Configuration variables
  proxy_container_name                  = "phoenix-default-12"

}

```

## Inputs

| Name                               | Description                                                                                                                                                                                                                                                                                                                   | Type          | Default         | Required |
|------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|-----------------|----------|
| app                                | App name                                                                                                                                                                                                                                                                                                                      | `string`      | "sytara"        | yes      |
| env                                | Environment                                                                                                                                                                                                                                                                                                                   | `string`      | "dev"           | yes      |
| region                             |                              Region                                                                                                                                                                                                                                                                                                 | `string`            | n/a             | yes       |
| healthcheck_path                   |                                  Path of the healthcheck                                                                                                                                                                                                                                                                                             | `string`            | n/a             | yes       |
| td_family                          | A unique name for your task definition                                                                                                                                                                                                                                                                                        | `string`      | "phoenix-family" | yes      |
| td_container_definitions           | A list of valid container definitions provided as a single valid JSON document. Please note that you should only provide values that are part of the container definition document. For a detailed description of what parameters are available, see the Task Definition Parameters section from the official Developer Guide | `string`      | n/a             | yes      |
| td_task_role_arn                   | The ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services                                                                                                                                                                                                                            | `string`      | n/a             | no       |
| td_execution_role_arn              | The Amazon Resource Name (ARN) of the task execution role that the Amazon ECS container agent and the Docker daemon can assume                                                                                                                                                                                                | `string`      | n/a             | no       |
| td_network_mode                    | The Docker networking mode to use for the containers in the task. The valid values are none, bridge, awsvpc, and host                                                                                                                                                                                                         | `string`      | "none"          | no       |
| td_ipc_mode                        | The IPC resource namespace to be used for the containers in the task The valid values are host, task, and none                                                                                                                                                                                                                | `string`      | "none"          | no       |
| td_pid_mode                        | The process namespace to use for the containers in the task. The valid values are host and task                                                                                                                                                                                                                               | `string`      | "task"          | no       |
|                                    |                                                                                                                                                                                                                                                                                                                               | ``            | n/a             | no       |
|                                    |                                                                                                                                                                                                                                                                                                                               | ``            | n/a             | no       |
| td_cpu                             | The number of cpu units used by the task. If the requires_compatibilities is FARGATE this field is required                                                                                                                                                                                                                   | `number`      | 2               | no       |
| td_memory                          | The amount (in MiB) of memory used by the task. If the requires_compatibilities is FARGATE this field is required                                                                                                                                                                                                             | `number`      | 1024            | no       |
|                                    |                                                                                                                                                                                                                                                                                                                               | ``            | n/a             | no       |
|                                    |                                                                                                                                                                                                                                                                                                                               | ``            | n/a             | no       |
| td_tags                            | Key-value map of resource tags                                                                                                                                                                                                                                                                                                | `map(string)` | n/a             | no       |
| volume_name                        | The name of the volume. This name is referenced in the sourceVolume parameter of container definition in the mountPoints section                                                                                                                                                                                              | `string`      | "phoenix-volume" | yes      |
| volume_host_path                   | The path on the host container instance that is presented to the container. If not set, ECS will create a nonpersistent data volume that starts empty and is deleted after the task has finished                                                                                                                              | `string`      | n/a             | no       |
|                                    |                                                                                                                                                                                                                                                                                                                               | ``            | n/a             | no       |
|                                    |                                                                                                                                                                                                                                                                                                                               | ``            | n/a             | no       |
| dvc_scope                          | The scope for the Docker volume, which determines its lifecycle, either task or shared. Docker volumes that are scoped to a task are automatically provisioned when the task starts and destroyed when the task stops. Docker volumes that are scoped as shared persist after the task stops                                  | `string`      | "task"          | no       |
| dvc_autoprovision                  | If this value is true, the Docker volume is created if it does not already exist. Note: This field is only used if the scope is shared                                                                                                                                                                                        | `bool`        | false           | no       |
| dvc_driver                         | The Docker volume driver to use. The driver value must match the driver name provided by Docker because it is used for task placement                                                                                                                                                                                         | `string`      | n/a             | no       |
| dvc_driver_opts                    | A map of Docker driver specific options                                                                                                                                                                                                                                                                                       | `map(string)` | n/a             | no       |
| dvc_labels                         | A map of custom metadata to add to your Docker volume                                                                                                                                                                                                                                                                         | `map(string)` | n/a             | no       |
| efs_file_system_id                 | The ID of the EFS File System                                                                                                                                                                                                                                                                                                 | `string`      | n/a             | yes      |
| efs_root_directory                 | The directory within the Amazon EFS file system to mount as the root directory inside the host. If this parameter is omitted, the root of the Amazon EFS volume will be used. Specifying / will have the same effect as omitting this parameter. This argument is ignored when using authorization_config                     | `string`      | n/a             | no       |
| efs_transit_encryption             | Whether or not to enable encryption for Amazon EFS data in transit between the Amazon ECS host and the Amazon EFS server. Transit encryption must be enabled if Amazon EFS IAM authorization is used. Valid values: ENABLED, DISABLED. If this parameter is omitted, the default value of DISABLED is used                    | `string`      | "DISABLED"      | no       |
| efs_transit_encryption_port        | The port to use for transit encryption. If you do not specify a transit encryption port, it will use the port selection strategy that the Amazon EFS mount helper uses                                                                                                                                                        | `string`      | n/a             | no       |
|                                    |                                                                                                                                                                                                                                                                                                                               | ``            | n/a             | no       |
| efs_authorization_access_point_id  | The access point ID to use. If an access point is specified, the root directory value will be relative to the directory set for the access point. If specified, transit encryption must be enabled in the EFSVolumeConfiguration                                                                                              | `string`      | n/a             | no       |
| efs_authorization_iam              | Whether or not to use the Amazon ECS task IAM role defined in a task definition when mounting the Amazon EFS file system. If enabled, transit encryption must be enabled in the EFSVolumeConfiguration. Valid values: ENABLED, DISABLED. If this parameter is omitted, the default value of DISABLED is used                  | `string`      | "DISABLED"      | no       |
| placement_constraints_type         | The type of constraint. Use memberOf to restrict selection to a group of valid candidates. Note that distinctInstance is not supported in task definitions                                                                                                                                                                    | `string`      | n/a             | yes      |
| placement_constraints_expression   | Cluster Query Language expression to apply to the constraint                                                                                                                                                                                                                                                                  | `string`      | n/a             | no       |
| proxy_container_name               | The name of the container that will serve as the App Mesh proxy                                                                                                                                                                                                                                                               | `string`      | n/a             | yes      |
| proxy_properties                   | The set of network configuration parameters to provide the Container Network Interface (CNI) plugin, specified a key-value mapping                                                                                                                                                                                            | `map(string)` | n/a             | yes      |
| proxy_type                         | The proxy type. The default value is APPMESH. The only supported value is APPMESH                                                                                                                                                                                                                                             | `string`      | "APPMESH"       | no       |
| inference_accelerators_device_name | The Elastic Inference accelerator device name. The deviceName must also be referenced in a container definition as a ResourceRequirement                                                                                                                                                                                      | `string`      | n/a             | yes      |
| inference_accelerators_device_type | The Elastic Inference accelerator type to use                                                                                                                                                                                                                                                                                 | `string`      | n/a             | yes      |
|                                    |                                                                                                                                                                                                                                                                                                                               | ``            | n/a             | no       |
| db_host                            |                            Database host                                                                                                                                                                                                                                                                                                   | `string`            | n/a             | yes       |
| db_port                            |                  Database port                                                                                                                                                                                                                                                                                                             | `string`            | n/a             | yes       |
| db_name                            |                  Database name                                                                                                                                                                                                                                                                                                             | `string`            | n/a             | yes       |
| db_master_username                 |                 Database master username                                                                                                                                                                                                                                                                                                              | `string`            | n/a             | yes       |
| db_master_password                 |                              Database master password                                                                                                                                                                                                                                                                                                 | `string`            | n/a             | yes       |
| vpc_id                             |        ID of the VPC                                                                                                                                                                                                                                                                                                                       | `string`            | n/a             | yes       |
| subnet_ids                         |                IDs of the subnets                                                                                                                                                                                                                                                                                                                | `list(any)`            | n/a             | yes       |
| ecr_id                             |                    ID of the  ECR repository                                                                                                                                                                                                                                                                                                           | `string`            | n/a             | yes       |
| ecr_url                            |               URL of the  ECR repository                                                                                                                                                                                                                                                                                                                | `string`            | n/a             | yes       |
| ecr_image_tag                      |               Tag of the ECR image                                                                                                                                                                                                                                                                                                                | `string`            | n/a             | yes       |
| ecs_cluster_id                     |                ID of the ECS cluster                                                                                                                                                                                                                                                                                                               | `string`            | n/a             | yes       |
| ecs_sg                             |                       Security group of the ECS                                                                                                                                                                                                                                                                                                        | `string`            | n/a             | yes       |
| alb_arn                            |                 ARN of the application load balancer                                                                                                                                                                                                                                                                                                              | `string`            | n/a             | yes       |


## Outputs

| Name              | Description                                     |
|-------------------|-------------------------------------------------|
| task_def_arn      | ARN of the ecs task definition                  |
| task_def_revision | The revision of the task in a particular family |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
