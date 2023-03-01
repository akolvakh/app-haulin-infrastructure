variable "directory_id" {}

variable "user_name" {
  description = "Should match with AD user"
}

variable "bundle_id" {
  default = "wsb-gm4d5tx2v" # Performance with Windows 10 (Server 2016 based)
}

variable "encryption_key" {
  default = "alias/aws/workspaces"
}

variable "compute_type" {
  description = "Valid values are VALUE, STANDARD, PERFORMANCE, POWER, GRAPHICS, POWERPRO and GRAPHICSPRO."
  default     = "PERFORMANCE"
}

variable "user_volume_size" {
  default = 50
}

variable "root_volume_size" {
  default = 50
}

variable "running_mode" {
  description = "Valid values are AUTO_STOP and ALWAYS_ON."
  default     = "AUTO_STOP"
}

variable "auto_stop_timeout" {
  description = "The time after a user logs off when WorkSpaces are automatically stopped. Configured in 60-minute intervals."
  default     = 60
}

variable "tags" {
  type = map(any)
}
