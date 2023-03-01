variable "alb_vpc_id" {
  type        = string
  description = "VPC where the ALB being created to live in"
}

variable "alb_subnets" {
  type        = list(string)
  description = "subnets where the ALB being created to live in"
}
variable "alb_public_ips" {
  type        = list(string)
  description = "EIP Allocation IDs of public IPs addresses to assign to the ALB"
  default     = []
}
variable "tag_role" {
  type    = string
  default = "vpn-proxy-static-ip"
}
variable "tag_description" {
  description = "short and meaningful description. What is intention ro use this module now?"
}
variable "certificate_arn" {
  description = "arn of TLS cert  for NLB listener"
}


variable "nlb_additional_tags" {
  type        = map(string)
  description = "map of tags to be added to all resources created by this module"
  default     = {}
}
