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

variable "enabled" {
  description = "(Optional) Whether to create an amazon issued certificate."
  type        = bool
  default     = true
}

variable "private_enabled" {
  description = "(Optional) Whether to creating a private CA issued certificate."
  type        = bool
  default     = false
}

variable "importing_enabled" {
  description = "(Optional) Whether to import an existing certificate."
  type        = bool
  default     = false
}

variable "process_domain_validation_options" {
  description = "(Optional) Flag to enable/disable processing of the record to add to the DNS zone to complete certificate validation."
  type        = bool
  default     = true
}

variable "wait_for_certificate_issued" {
  description = "(Optional) Whether to wait for the certificate to be issued by ACM (the certificate status changed from `Pending Validation` to `Issued`)."
  type        = bool
  default     = false
}

#------------------------------------------------------------------------------
# Route53 variables
#------------------------------------------------------------------------------
#ToDo
#add all needed variables

variable "zone_name" {
  description = "(Optional) Name of the zone."
  type        = string
  default     = "phoenix.com"
}

variable "hosted_zone_id" {
  description = "(Required) Route 53 Zone ID for DNS validation records."
  type        = string
}

variable "ttl" {
  description = "(Optional) The TTL of the record to add to the DNS zone to complete certificate validation."
  type        = string
  default     = "300"
}

#------------------------------------------------------------------------------
# Certificate manager variables
#------------------------------------------------------------------------------
variable "cert_tags" {
  description = "(Optional) A map of tags to assign to the resource."
  type        = map(string)
  default = {
    Environment = "dev",
    App         = "phoenix",
    Name        = "phoenix-cert"
  }
}

#------------------------------------------------------------------------------
# Creating an amazon issued certificate variables
#------------------------------------------------------------------------------
variable "domain_name" {
  description = "(Required) A domain name for which the certificate should be issued."
  type        = string
}

variable "subject_alternative_names" {
  description = "(Optional) Set of domains that should be SANs in the issued certificate. To remove all elements of a previously configured list, set this value equal to an empty list ([]) or use the terraform taint command to trigger recreation."
  type        = list(string)
  default     = []
}

variable "validation_method" {
  description = "(Required) Which method to use for validation. DNS or EMAIL are valid, NONE can be used for certificates that were imported into ACM and then into Terraform."
  type        = string
  default     = "DNS"
}

#------------------------------------------------------------------------------
# Importing an existing certificate variables
#------------------------------------------------------------------------------
variable "private_key" {
  description = "(Required) The certificate's PEM-formatted private key."
  type        = string
}

variable "certificate_body" {
  description = "(Required) The certificate's PEM-formatted public key."
  type        = string
}

variable "certificate_chain" {
  description = "(Optional) The certificate's PEM-formatted chain."
  type        = string
  default     = "/"
}

#------------------------------------------------------------------------------
# Creating a private CA issued certificate variables
#------------------------------------------------------------------------------
variable "private_domain_name" {
  description = "(Required) A domain name for which the certificate should be issued."
  type        = string
}

variable "private_certificate_authority_arn" {
  description = "(Required) ARN of an ACMPCA."
  type        = string
}

variable "private_subject_alternative_names" {
  description = "(Optional) Set of domains that should be SANs in the issued certificate. To remove all elements of a previously configured list, set this value equal to an empty list ([]) or use the terraform taint command to trigger recreation."
  type        = list(string)
  default     = []
}

#------------------------------------------------------------------------------
# Options configuration variables
#------------------------------------------------------------------------------
variable "certificate_transparency_logging_preference" {
  description = "(Optional) Specifies whether certificate details should be added to a certificate transparency log. Valid values are ENABLED or DISABLED."
  type        = string
  default     = "DISABLED"
}

#------------------------------------------------------------------------------
# Certificate manager validation variables
#------------------------------------------------------------------------------
variable "cmv_certificate_arn" {
  description = "(Required) The ARN of the certificate that is being validated."
  type        = string
}

variable "cmv_validation_record_fqdns" {
  description = "(Optional) List of FQDNs that implement the validation. Only valid for DNS validation method ACM certificates. If this is set, the resource can implement additional sanity checks and has an explicit dependency on the resource that is implementing the validation."
  type        = list(string)
  default     = []
}
