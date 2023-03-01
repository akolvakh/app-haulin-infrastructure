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

variable "private_enabled" {
  description = "(Optional) Whether to create private Route53 zone."
  type        = bool
  default     = false
}

variable "record_enabled" {
  description = "(Optional) Whether to create Route53 record set."
  type        = bool
  default     = false
}

variable "public_enabled" {
  description = "(Optional) Whether to create public Route53 zone."
  type        = bool
  default     = false
}

variable "record_set_enabled" {
  description = "(Optional) Whether to create seperate Route53 record set."
  type        = bool
  default     = false
}

variable "failover_enabled" {
  description = "(Optional) Whether to create Route53 record set."
  type        = bool
  default     = false
}

variable "latency_enabled" {
  description = "(Optional) Whether to create Route53 record set."
  type        = bool
  default     = false
}

variable "geolocation_enabled" {
  description = "(Optional) Whether to create Route53 record set."
  type        = bool
  default     = false
}

variable "weighted_enabled" {
  description = "(Optional) Whether to create Route53 record set."
  type        = bool
  default     = false
}

#------------------------------------------------------------------------------
# Route53 zone variables
#------------------------------------------------------------------------------
variable "domain_name" {
  description = "(Required) This is the name of the hosted zone."
  type        = string
}

variable "comment" {
  description = "(Optional) A comment for the hosted zone. Defaults to 'Managed by Terraform'."
  type        = string
  default     = "/"
}

variable "delegation_set_id" {
  description = "(Optional) The ID of the reusable delegation set whose NS records you want to assign to the hosted zone. Conflicts with vpc as delegation sets can only be used for public zones."
  type        = string
  default     = "/"
}

variable "force_destroy" {
  description = "(Optional) Whether to destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone."
  type        = bool
  default     = true
}

variable "tags" {
  description = "(Optional) A map of tags to assign to the zone."
  type        = map(string)
  default = {
    Environment = "dev",
    App         = "phoenix",
    Name        = "phoenix-route53"
  }
}

#------------------------------------------------------------------------------
# VPC variables
#------------------------------------------------------------------------------
variable "vpc_id" {
  description = "(Optional) Configuration block(s) specifying VPC(s) to associate with a private hosted zone. Conflicts with the delegation_set_id argument in this resource and any aws_route53_zone_association resource specifying the same zone ID."
  type        = string
  default     = "/"
}

variable "vpc_region" {
  description = "(Optional) Region of the VPC to associate. Defaults to AWS provider region."
  type        = string
  default     = "/"
}

#------------------------------------------------------------------------------
# Route53 record variables
#------------------------------------------------------------------------------
variable "zone_id" {
  description = "(Required) The ID of the hosted zone to contain this record."
  type        = string
}

variable "names" {
  description = "(Optional) The name of the record."
  type        = list(any)
  default     = []
}

variable "types" {
  description = "(Optional) The record type. Valid values are A, AAAA, CAA, CNAME, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT."
  type        = list(any)
  default     = []
}

variable "ttls" {
  description = "(Required for non-alias records) The TTL of the record."
  type        = list(any)
  default     = []
}

variable "records" {
  description = "(Required for non-alias records) A string list of records. To specify a single record value longer than 255 characters such as a TXT record for DKIM, add \"\" inside the Terraform configuration string (e.g. \"first255characters\"\"morecharacters\")."
  type        = list(any)
  default     = []
}

variable "set_identifiers" {
  description = "(Optional) Unique identifier to differentiate records with routing policies from one another. Required if using failover, geolocation, latency, or weighted routing policies documented below."
  type        = list(any)
  default     = []
}

variable "health_check_ids" {
  description = "(Optional) The health check the record should be associated with."
  type        = list(any)
  default     = []
}

variable "alias" {
  description = "(Optional) An alias block. Conflicts with ttl & records. Alias record documented below."
  type        = map(any)
  default = {
    "names"                   = [],
    "zone_ids"                = [],
    "evaluate_target_healths" = []
  }
}

variable "failover_routing_policies" {
  description = "(Optional) A block indicating the routing behavior when associated health check fails. Conflicts with any other routing policy. Documented below."
  type        = string
  default     = null
}

variable "geolocation_routing_policies" {
  description = "(Optional) A block indicating a routing policy based on the geolocation of the requestor. Conflicts with any other routing policy. Documented below."
  type        = string
  default     = null
}

variable "latency_routing_policies" {
  description = "(Optional) A block indicating a routing policy based on the latency between the requestor and an AWS region. Conflicts with any other routing policy. Documented below."
  type        = string
  default     = null
}

variable "weighted_routing_policies" {
  description = "(Optional) A block indicating a weighted routing policy. Conflicts with any other routing policy. Documented below."
  type        = string
  default     = null
}

variable "multivalue_answer_routing_policies" {
  description = "(Optional) Set to true to indicate a multivalue answer routing policy. Conflicts with any other routing policy."
  type        = list(any)
  default     = []
}

variable "allow_overwrites" {
  description = "(Optional) Allow creation of this record in Terraform to overwrite an existing record, if any. This does not affect the ability to update the record in Terraform and does not prevent other resources within Terraform or manual Route 53 changes outside Terraform from overwriting this record. false by default. This configuration is not recommended for most environments."
  type        = list(any)
  default     = []
}

#------------------------------------------------------------------------------
# Alias records variables
#------------------------------------------------------------------------------
variable "alias_name" {
  description = "(Required) DNS domain name for a CloudFront distribution, S3 bucket, ELB, or another resource record set in this hosted zone."
  type        = string
}

variable "alias_zone_id" {
  description = "(Required) Hosted zone ID for a CloudFront distribution, S3 bucket, ELB, or Route 53 hosted zone. See resource_elb.zone_id for example."
  type        = string
}

variable "alias_evaluate_target_health" {
  description = "(Required) Set to true if you want Route 53 to determine whether to respond to DNS queries using this resource record set by checking the health of the resource record set. Some resources have special requirements."
  type        = bool
}

#------------------------------------------------------------------------------
# Failover routing policies variables
#------------------------------------------------------------------------------
variable "failover_type" {
  description = "(Required) PRIMARY or SECONDARY. A PRIMARY record will be served if its healthcheck is passing, otherwise the SECONDARY will be served. See http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-configuring-options.html#dns-failover-failover-rrsets."
  type        = string
}

#------------------------------------------------------------------------------
# Geolocation routing policies variables
#------------------------------------------------------------------------------
variable "geolocation_continent" {
  description = "(Required) A two-letter continent code. See http://docs.aws.amazon.com/Route53/latest/APIReference/API_GetGeoLocation.html for code details. Either continent or country must be specified."
  type        = string
}

variable "geolocation_country" {
  description = "(Required) A two-character country code or * to indicate a default resource record set."
  type        = string
}

variable "geolocation_subdivision" {
  description = "(Optional) A subdivision code for a country."
  type        = string
  default     = "/"
}

#------------------------------------------------------------------------------
# Latency routing policies variables
#------------------------------------------------------------------------------
variable "latency_region" {
  description = "(Required) An AWS region from which to measure latency. See http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-policy.html#routing-policy-latency."
  type        = string
}

#------------------------------------------------------------------------------
# Weighted routing policies variables
#------------------------------------------------------------------------------
variable "weight" {
  description = "(Required) A numeric value indicating the relative weight of the record. See http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-policy.html#routing-policy-weighted."
  type        = number
}

#------------------------------------------------------------------------------
# VPC association variables
#------------------------------------------------------------------------------
variable "vpc_acssociation_enabled" {
  description = "(Optional) Whether to create Route53 vpc association."
  type        = bool
  default     = false
}

variable "secondary_vpc_id" {
  description = "(Optional) The VPC to associate with the private hosted zone."
  type        = string
  default     = "/"
}

variable "secondary_vpc_region" {
  description = "(Optional) The VPC's region. Defaults to the region of the AWS provider."
  type        = string
  default     = "/"
}
