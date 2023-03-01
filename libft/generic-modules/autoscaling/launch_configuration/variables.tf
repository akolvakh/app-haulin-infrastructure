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

#------------------------------------------------------------------------------
# Launch configuration variables
#------------------------------------------------------------------------------
variable "count_size" {
  description = "(Required) Whether to create launch configuration."
  type        = number
}

variable "name" {
  description = "(Required) Creates a unique name beginning with the specified prefix."
  type        = string
}

variable "image_id" {
  description = "(Required) The EC2 image ID to launch."
  type        = string
}

variable "instance_type" {
  description = "(Required) The size of instance to launch."
  type        = string
}

variable "iam_instance_profile" {
  description = "(Optional) The IAM instance profile to associate with launched instances."
  default     = ""
}

variable "key_name" {
  description = "(Optional) The key name that should be used for the instance."
  type        = string
  default     = ""
}

variable "security_groups" {
  description = "(Required) A list of security group IDs to assign to the launch configuration."
  type        = list(any)
}

variable "associate_public_ip_address" {
  description = "(Optional) Associate a public ip address with an instance in a VPC."
  type        = bool
  default     = false
}

variable "user_data" {
  description = "(Optional) The user data to provide when launching the instance."
  default     = ""
}

variable "enable_monitoring" {
  description = "(Optional) Enables/disables detailed monitoring. This is enabled by default."
  type        = bool
  default     = true
}

variable "ebs_optimized" {
  description = "(Optional) If true, the launched EC2 instance will be EBS-optimized."
  type        = bool
  default     = false
}

#ToDo Check: CKV_AWS_8: "Ensure all data stored in the Launch configuration EBS is securely encrypted"
variable "root_block_device" {
  description = "(Optional) Customize details about the root block device of the instance."
  type        = list(any)
  default     = []
}

#ToDo Check: CKV_AWS_8: "Ensure all data stored in the Launch configuration EBS is securely encrypted"
variable "ebs_block_device" {
  description = "(Optional) Additional EBS block devices to attach to the instance."
  type        = list(any)
  default     = []
}

variable "ephemeral_block_device" {
  description = "(Optional) Customize Ephemeral (also known as 'Instance Store') volumes on the instance."
  type        = list(any)
  default     = []
}

variable "spot_price" {
  description = "(Optional) The price to use for reserving spot instances."
  type        = number
  default     = 0
}

variable "placement_tenancy" {
  description = "(Optional) The tenancy of the instance. Valid values are 'default' or 'dedicated'."
  type        = string
  default     = "default"
}

variable "root_block_device_encrypted" {
  description = "(Optional) Whether root block device encryption on or off."
  type        = bool
  default     = true
}

variable "create_before_destroy" {
  description = "(Optional) Whether create before destroy or not."
  type        = bool
  default     = true
}
