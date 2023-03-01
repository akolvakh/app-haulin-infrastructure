#------------------------------------------------------------------------------
# General variables
#------------------------------------------------------------------------------
variable "app" {
  description = "(Required) App name."
  type        = string
}

variable "env" {
  description = "(Required) Environment."
  type        = string
}

variable "region" {
  description = "(Required) Region."
  type        = string
}

variable "healthcheck_path" {
  description = "(Required) Path of the healthcheck."
  type        = string
}

#------------------------------------------------------------------------------
# AWS ECS Task Definition variables (top-level)
#------------------------------------------------------------------------------
variable "td_family" {
  description = "(Required) A unique name for your task definition."
  type        = string
}

variable "td_container_definitions" {
  description = "(Required) A list of valid container definitions provided as a single valid JSON document. Please note that you should only provide values that are part of the container definition document. For a detailed description of what parameters are available, see the Task Definition Parameters section from the official Developer Guide."
  type        = string
}

variable "td_task_role_arn" {
  description = "(Optional) The ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services."
  type        = string
  default     = "/"
}

variable "td_execution_role_arn" {
  description = "(Optional) The Amazon Resource Name (ARN) of the task execution role that the Amazon ECS container agent and the Docker daemon can assume."
  type        = string
  default     = "/"
}

variable "td_network_mode" {
  description = "(Optional) The Docker networking mode to use for the containers in the task. The valid values are none, bridge, awsvpc, and host."
  type        = string
  default     = "none"
}

variable "td_ipc_mode" {
  description = "(Optional) The IPC resource namespace to be used for the containers in the task The valid values are host, task, and none."
  type        = string
  default     = "none"
}

variable "td_pid_mode" {
  description = "(Optional) The process namespace to use for the containers in the task. The valid values are host and task."
  type        = string
  default     = "task"
}

variable "td_cpu" {
  description = "(Optional) The number of cpu units used by the task. If the requires_compatibilities is FARGATE this field is required."
  type        = number
  default     = 2
}

variable "td_memory" {
  description = "(Optional) The amount (in MiB) of memory used by the task. If the requires_compatibilities is FARGATE this field is required."
  type        = number
  default     = 1024
}

variable "td_requires_compatibilities" {
  description = "(Optional) A set of launch types required by the task. The valid values are EC2 and FARGATE."
  type        = string
  default     = "FARGATE"
}

variable "td_tags" {
  description = "(Optional) Key-value map of resource tags."
  type        = map(string)
  default = {
    Environment = "dev",
    App         = "phoenix",
    Name        = "phoenix-td",
    Terraform   = true
  }
}

#------------------------------------------------------------------------------
# Volume Block variables
#------------------------------------------------------------------------------
#ToDo
#required
variable "volume_name" {
  description = "(Optional) The name of the volume. This name is referenced in the sourceVolume parameter of container definition in the mountPoints section."
  type        = string
  default     = "/"
}

variable "volume_host_path" {
  description = "(Optional) The path on the host container instance that is presented to the container. If not set, ECS will create a nonpersistent data volume that starts empty and is deleted after the task has finished."
  type        = string
  default     = "/"
}

#------------------------------------------------------------------------------
# Docker Volume Configuration variables
#------------------------------------------------------------------------------
variable "dvc_scope" {
  description = "(Optional) The scope for the Docker volume, which determines its lifecycle, either task or shared. Docker volumes that are scoped to a task are automatically provisioned when the task starts and destroyed when the task stops. Docker volumes that are scoped as shared persist after the task stops."
  type        = string
  default     = "task"
}

variable "dvc_autoprovision" {
  description = "(Optional) If this value is true, the Docker volume is created if it does not already exist. Note: This field is only used if the scope is shared."
  type        = bool
  default     = false
}

variable "dvc_driver" {
  description = "(Optional) The Docker volume driver to use. The driver value must match the driver name provided by Docker because it is used for task placement."
  type        = string
  default     = "/"
}

variable "dvc_driver_opts" {
  description = "(Optional) A map of Docker driver specific options."
  type        = map(string)
  default     = {}
}

variable "dvc_labels" {
  description = "(Optional) A map of custom metadata to add to your Docker volume."
  type        = map(string)
  default     = {}
}

#------------------------------------------------------------------------------
# EFS Volume Configuration variables
#------------------------------------------------------------------------------
#ToDo
#required
variable "efs_file_system_id" {
  description = "(Optional) The ID of the EFS File System."
  type        = string
  default     = "/"
}

variable "efs_root_directory" {
  description = "(Optional) The directory within the Amazon EFS file system to mount as the root directory inside the host. If this parameter is omitted, the root of the Amazon EFS volume will be used. Specifying / will have the same effect as omitting this parameter. This argument is ignored when using authorization_config."
  type        = string
  default     = "/"
}

variable "efs_transit_encryption" {
  description = "(Optional) Whether or not to enable encryption for Amazon EFS data in transit between the Amazon ECS host and the Amazon EFS server. Transit encryption must be enabled if Amazon EFS IAM authorization is used. Valid values: ENABLED, DISABLED. If this parameter is omitted, the default value of DISABLED is used."
  type        = string
  default     = "DISABLED"
}

variable "efs_transit_encryption_port" {
  description = "(Optional) The port to use for transit encryption. If you do not specify a transit encryption port, it will use the port selection strategy that the Amazon EFS mount helper uses."
  type        = string
  default     = "/"
}

#------------------------------------------------------------------------------
# EFS Autorization Configuration variables
#------------------------------------------------------------------------------
#ToDo
#required?
variable "efs_authorization_access_point_id" {
  description = "(Optional) The access point ID to use. If an access point is specified, the root directory value will be relative to the directory set for the access point. If specified, transit encryption must be enabled in the EFSVolumeConfiguration."
  type        = string
  default     = "/"
}

#ToDo
#required?
variable "efs_authorization_iam" {
  description = "(Optional) Whether or not to use the Amazon ECS task IAM role defined in a task definition when mounting the Amazon EFS file system. If enabled, transit encryption must be enabled in the EFSVolumeConfiguration. Valid values: ENABLED, DISABLED. If this parameter is omitted, the default value of DISABLED is used."
  type        = string
  default     = "DISABLED"
}

#------------------------------------------------------------------------------
# Placement Constraints variables
#------------------------------------------------------------------------------
variable "td_placement_constraints" {
  description = "(Optional) A set of placement constraints rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10."
  type        = number
  default     = 2
}

#ToDo
#required
variable "placement_constraints_type" {
  description = "(Optional) The type of constraint. Use memberOf to restrict selection to a group of valid candidates. Note that distinctInstance is not supported in task definitions."
  type        = string
  default     = "/"
}

variable "placement_constraints_expression" {
  description = "(Optional) Cluster Query Language expression to apply to the constraint."
  type        = string
  default     = "/"
}

#------------------------------------------------------------------------------
# Proxy Configuration variables
#------------------------------------------------------------------------------
#ToDo
#required
variable "proxy_container_name" {
  description = "(Optional) The name of the container that will serve as the App Mesh proxy."
  type        = string
  default     = "/"
}

variable "proxy_properties" {
  description = "(Required) The set of network configuration parameters to provide the Container Network Interface (CNI) plugin, specified a key-value mapping."
  type        = map(string)
  default     = {}
}

variable "proxy_type" {
  description = "(Optional) The proxy type. The default value is APPMESH. The only supported value is APPMESH."
  type        = string
  default     = "APPMESH"
}

#------------------------------------------------------------------------------
# Inference Accelerators variables
#------------------------------------------------------------------------------
#ToDo
#required
variable "inference_accelerators_device_name" {
  description = "(Optional) The Elastic Inference accelerator device name. The deviceName must also be referenced in a container definition as a ResourceRequirement."
  type        = string
  default     = "/"
}

#required
variable "inference_accelerators_device_type" {
  description = "(Optional) The Elastic Inference accelerator type to use."
  type        = string
  default     = "/"
}

#------------------------------------------------------------------------------
# VPC variables
#------------------------------------------------------------------------------
variable "vpc_id" {
  description = "(Required) ID of the VPC."
  type        = string
}

#------------------------------------------------------------------------------
# ECR variables
#------------------------------------------------------------------------------
variable "ecr_id" {
  description = "(Required) ID of the  ECR repository."
  type        = string
}

variable "ecr_url" {
  description = "(Required) URL of the  ECR repository."
  type        = string
}

variable "ecr_image_tag" {
  description = "(Required) Tag of the ECR image."
  type        = string
}

#------------------------------------------------------------------------------
# Etc variables
#------------------------------------------------------------------------------
variable "ecs_cluster_id" {
  description = "(Required) ID of the ECS cluster."
  type        = string
}

variable "ecs_sg" {
  description = "(Required) Security group of the ECS."
  type        = string
}

variable "subnet_ids" {
  description = "(Required) IDs of the subnets."
  type        = list(any)
}
