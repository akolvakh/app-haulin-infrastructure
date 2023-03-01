#------------------------------------------------------------------------------
# General variables
#------------------------------------------------------------------------------
variable "create_bucket" {
  description = "Controls if S3 bucket should be created"
  type        = bool
  default     = true
}
variable "create_policy" {
  description = "Shall a predefined Policy be applied for the bucket being created"
  type        = bool
  default     = true
}


variable "bucket" {
  description = "(Optional, Forces new resource) The name of the bucket. If omitted, Terraform will assign a random, unique name."
  type        = string
  default     = null
}

variable "bucket_prefix" {
  description = "(Optional, Forces new resource) Creates a unique bucket name beginning with the specified prefix. Conflicts with bucket."
  type        = string
  default     = null
}

variable "force_destroy" {
  description = "(Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  type        = bool
  default     = false
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the bucket."
  type        = map(string)
  default     = {}
}

#------------------------------------------------------------------------------
# SSE variables
#------------------------------------------------------------------------------
variable "server_side_encryption_configuration" {
  description = "Map containing server-side encryption configuration."
  type        = any
  default = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = true
      }
    }
  }
}

variable "sse_algorithm" {
  description = "SSE algorithm."
  type        = string
  default     = "AES256"
}

#------------------------------------------------------------------------------
# Logging variables
#------------------------------------------------------------------------------
variable "logging" {
  description = "Map containing access bucket logging configuration."
  type        = map(string)
  default     = {}
}

#------------------------------------------------------------------------------
# Lifecycle variables
#------------------------------------------------------------------------------
variable "lifecycle_rule" {
  description = "List of maps containing configuration of object lifecycle management."
  type        = any
  default     = []
}

#------------------------------------------------------------------------------
# Policies variables
#------------------------------------------------------------------------------
variable "policy" {
  description = "(Optional) A valid bucket policy JSON document. "
  type        = string
  default     = null
}

variable "attach_deny_insecure_transport_policy" {
  description = "Controls if S3 bucket should have deny non-SSL transport policy attached"
  type        = bool
  default     = true
}

#------------------------------------------------------------------------------
# ACLs variables
#------------------------------------------------------------------------------
variable "acl" {
  description = "(Optional) The canned ACL to apply. Defaults to 'private'. Conflicts with `grant`"
  type        = string
  default     = "private"
}

variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for this bucket."
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket."
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket."
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
  type        = bool
  default     = true
}

#------------------------------------------------------------------------------
# Versioning variables
#------------------------------------------------------------------------------
variable "versioning" {
  description = "Map containing versioning configuration."
  type        = map(string)
  default     = {}
}
