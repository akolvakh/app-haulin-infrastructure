variable "module_name" {
  type        = string
  description = "name of the phoenix module being applied by terraform"
}
variable "module_version" {
  type        = string
  description = "version of the phoenix module being applied by terraform"
}

variable "label" {}