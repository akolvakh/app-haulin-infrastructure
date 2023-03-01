# variable aws_region {}
# variable environment {}
variable "aws_account_id" {}

variable "common_name" {
  type        = string
  description = "Fully qualified domain name (FQDN) associated with the certificate subject. Must be less than or equal to 64 characters in length"
  default     = "phoenix.local"
}

variable "country" {
  type        = string
  description = "Two digit code that specifies the country in which the certificate subject located. Must be less than or equal to 2 characters in length"
  default     = "US"
}

variable "organization" {
  type        = string
  description = "Legal name of the organization with which the certificate subject is affiliated. Must be less than or equal to 64 characters in length."
  default     = "phoenix Inc"
}

variable "organizational_unit" {
  type        = string
  description = "A subdivision or unit of the organization (such as sales or finance) with which the certificate subject is affiliated. Must be less than or equal to 64 characters in length"
  default     = "IT"
}
