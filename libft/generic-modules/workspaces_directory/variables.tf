variable "directory_id" {}

variable "subnets" {
  type = list(string)
}

variable "tags" {
  type = map(any)
}

variable "self_service_permissions" {
  type        = map(any)
  description = "(true/false) https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/workspaces_directory"
}

variable "workspace_access_properties" {
  type        = map(any)
  description = "(ALLOW/DENY) https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/workspaces_directory"
}

variable "default_ou" {
  default = "OU=phoenix,DC=phoenix,DC=com"
}