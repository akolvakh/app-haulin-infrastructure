variable "key_name" {
  type        = string
  description = "name for the KMS_alias to be created for the KMS key. Prefix 'alias/' will be added automatically"
}
variable "policy_override_json" {
  type        = string
  description = "IAM policy json, intended OVERRIDE AND MERGE default key policy. Ref override_json in https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document. When SID in default  policy statement  and this one match - default policy statement will be overrident. When SID in statementn dont match - both statements will be merged. resulting policy will be applied to KMS key being created"
  default     = ""
}

variable "customer_master_key_spec" {
  type        = string
  description = "ref https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key"
  default     = "SYMMETRIC_DEFAULT"
}
variable "description" {
  type        = string
  description = "ref https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key"
}
variable "enable_key_rotation" {
  description = "ref https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key"
  default     = false
}

variable "key_usage" {
  description = "ref https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key"
  default     = "ENCRYPT_DECRYPT"

}
variable "bypass_policy_lockout_safety_check" {

  description = "ref https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key"
  default     = false
}
variable "multi_region" {

  description = "ref https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key"
  default     = false
}
variable "primary_key_arn" {
  description = "arn of primary key, if current one to be a replica. unset by default. a key either has multi_regional=true or has primary_key_Arn set"
  default     = null
}
variable "key_additional_tags" {
  description = "optional map of tags to be added to all resources created by this module. Say {Jira=Ticket-123}"
  default     = {}
}
