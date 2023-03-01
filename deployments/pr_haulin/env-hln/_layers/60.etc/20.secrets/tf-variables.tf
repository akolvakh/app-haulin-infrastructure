#--------------------------------------------------------------
# General
#--------------------------------------------------------------
variable "label" {}
variable "secrets_additional_tags" {
  description = "map of tags to be added to all resources created by this module"
  type        = map(any)
  default     = {}
}
variable "tf_framework_component_version" {
  description = "GIT tag or branch if no tag vailable, identifying terraform source code version being run. Set by Makefile Framework"
}
variable "doc_link_base" {
  type        = string
  description = "base url for wiki page holding documentation for the secret(s)"
  default     = "https://phoenix.atlassian.net/wiki/spaces/DOCUMENTAT/pages/471433238/Secrets+and+environment+specific+params"
}