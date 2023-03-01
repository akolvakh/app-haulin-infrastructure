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

#------------------------------------------------------------------------------
# S3 bucket variables
#------------------------------------------------------------------------------
variable "bucket" {
  description = "(Optional, Forces new resource) The name of the bucket. If omitted, Terraform will assign a random, unique name. Must be less than or equal to 63 characters in length."
  type        = string
  default     = "/"
}

variable "versioning" {
  description = "(Optional) A state of versioning."
  type        = bool
  default     = true
}

variable "bucket_name" {
  description = "(Required) Name of the bucket"
  type        = string
}

variable "bucket_prefix" {
  description = "(Optional, Forces new resource) Creates a unique bucket name beginning with the specified prefix. Conflicts with bucket. Must be less than or equal to 37 characters in length."
  type        = string
  default     = "bucket"
}
variable "acl" {
  description = "(Optional) The canned ACL to apply. Valid values are private, public-read, public-read-write, aws-exec-read, authenticated-read, and log-delivery-write. Defaults to private. Conflicts with grant."
  type        = string
  default     = "private"
}
variable "grant" {
  description = "(Optional) An ACL policy grant (documented below). Conflicts with acl."
  type        = string
  default     = "/"
}

variable "policy" {
  description = "(Optional) A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide."
  type        = string
  default     = "{}"
}

variable "s3_tags" {
  description = "(Optional) A map of tags to assign to the bucket."
  type        = map(string)
  default = {
    Environment = "dev",
    App         = "phoenix",
    Name        = "phoenix-s3-bucket",
    Terrafom    = true
  }
}

variable "force_destroy" {
  description = "(Optional, Default:false) A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  type        = bool
  default     = false
}

variable "acceleration_status" {
  description = "(Optional) Sets the accelerate configuration of an existing bucket. Can be Enabled or Suspended."
  type        = string
  default     = "Enabled"
}

variable "request_payer" {
  description = "(Optional) Specifies who should bear the cost of Amazon S3 data transfer. Can be either BucketOwner or Requester. By default, the owner of the S3 bucket would incur the costs of any data transfer. See Requester Pays Buckets developer guide for more information."
  type        = string
  default     = "BucketOwner"
}

#------------------------------------------------------------------------------
# Website object variables
#------------------------------------------------------------------------------
variable "index_document" {
  description = "(Required, unless using redirect_all_requests_to) Amazon S3 returns this index document when requests are made to the root domain or any of the subfolders."
  type        = string
}

variable "error_document" {
  description = " (Optional) An absolute path to the document to return in case of a 4XX error."
  type        = string
  default     = "/"
}

variable "redirect_all_requests_to" {
  description = "(Optional) A hostname to redirect all website requests for this bucket to. Hostname can optionally be prefixed with a protocol (http:// or https://) to use when redirecting requests. The default is the protocol that is used in the original request."
  type        = string
  default     = "/"
}

variable "routing_rules" {
  description = "(Optional) A json array containing routing rules describing redirect behavior and when redirects are applied."
  type        = string
  default     = "{}"
}

#------------------------------------------------------------------------------
# CORS object variables
#------------------------------------------------------------------------------
variable "allowed_headers" {
  description = "(Optional) Specifies which headers are allowed."
  type        = string
  default     = "/"
}

variable "allowed_methods" {
  description = "(Required) Specifies which methods are allowed. Can be GET, PUT, POST, DELETE or HEAD."
  type        = string
}

variable "allowed_origins" {
  description = "(Required) Specifies which origins are allowed."
  type        = string
}

variable "expose_headers" {
  description = "(Optional) Specifies expose header in the response."
  type        = string
  default     = "/"
}

variable "max_age_seconds" {
  description = "(Optional) Specifies time in seconds that browser can cache the response for a preflight request."
  type        = number
  default     = 60
}

#------------------------------------------------------------------------------
# Versioning object variables
#------------------------------------------------------------------------------
variable "versioning_enabled" {
  description = "(Optional) Enable versioning. Once you version-enable a bucket, it can never return to an unversioned state. You can, however, suspend versioning on that bucket."
  type        = bool
  default     = false
}

#ToDo Check: CKV_AWS_52: "Ensure S3 bucket has MFA delete enabled"
variable "mfa_delete" {
  description = "(Optional) Enable MFA delete for either Change the versioning state of your bucket or Permanently delete an object version. Default is false. This cannot be used to toggle this setting but is available to allow managed buckets to reflect the state in AWS."
  type        = bool
  #
  default = true
}

#------------------------------------------------------------------------------
# Logging object variables
#------------------------------------------------------------------------------
variable "target_bucket" {
  description = "(Required) The name of the bucket that will receive the log objects."
  type        = string
}

variable "target_prefix" {
  description = "(Optional) To specify a key prefix for log objects."
  type        = string
  default     = "log/"
}

#------------------------------------------------------------------------------
# Lifecycle_rule object variables
#------------------------------------------------------------------------------
variable "id" {
  description = "(Optional) Unique identifier for the rule. Must be less than or equal to 255 characters in length."
  type        = string
  default     = "/"
}

variable "prefix" {
  description = "(Optional) Object key prefix identifying one or more objects to which the rule applies."
  type        = string
  default     = "/"
}

variable "lifecycle_rule_tags" {
  description = "(Optional) A map of tags to assign to the bucket."
  type        = map(string)
  default = {
    Environment = "dev",
    App         = "phoenix",
    Name        = "phoenix-s3-bucket-lifecycle-rule",
    Terrafom    = true
  }
}

variable "lifecycle_rule_enabled" {
  description = "(Required) Specifies lifecycle rule status."
  type        = bool
}

variable "abort_incomplete_multipart_upload_days" {
  description = "(Optional) Specifies the number of days after initiating a multipart upload when the multipart upload must be completed."
  type        = number
  default     = 7
}

#------------------------------------------------------------------------------
# Expiration object variables
#------------------------------------------------------------------------------
variable "expiration_date" {
  description = "(Optional) Specifies the date after which you want the corresponding action to take effect."
  type        = string
  default     = "/"
}

variable "expiration_days" {
  description = "(Optional) Specifies the number of days after object creation when the specific rule action takes effect."
  type        = number
  default     = 7
}

variable "expired_object_delete_marker" {
  description = "(Optional) On a versioned bucket (versioning-enabled or versioning-suspended bucket), you can add this element in the lifecycle configuration to direct Amazon S3 to delete expired object delete markers. This cannot be specified with Days or Date in a Lifecycle Expiration Policy."
  type        = string
  default     = "/"
}

#------------------------------------------------------------------------------
# Transition object variables
#------------------------------------------------------------------------------
variable "transition_date" {
  description = "(Optional) Specifies the date after which you want the corresponding action to take effect."
  type        = string
  default     = "/"
}

variable "transition_days" {
  description = "(Optional) Specifies the number of days after object creation when the specific rule action takes effect."
  type        = number
  default     = 7
}

variable "storage_class" {
  description = "(Required) Specifies the Amazon S3 storage class to which you want the object to transition. Can be ONEZONE_IA, STANDARD_IA, INTELLIGENT_TIERING, GLACIER, or DEEP_ARCHIVE."
  type        = string
}

#------------------------------------------------------------------------------
# Noncurrent_version_expiration object variables
#------------------------------------------------------------------------------
variable "noncurrent_version_expiration_days" {
  description = "(Required) Specifies the number of days noncurrent object versions expire."
  type        = number
}

#------------------------------------------------------------------------------
# Noncurrent_version_transition object variables
#------------------------------------------------------------------------------
variable "noncurrent_version_transition_days" {
  description = "(Required) Specifies the number of days noncurrent object versions transition."
  type        = number
}

variable "noncurrent_version_transition_storage_class" {
  description = "(Required) Specifies the Amazon S3 storage class to which you want the noncurrent object versions to transition. Can be ONEZONE_IA, STANDARD_IA, INTELLIGENT_TIERING, GLACIER, or DEEP_ARCHIVE."
  type        = string
}

#------------------------------------------------------------------------------
# Replication_configuration object variables
#------------------------------------------------------------------------------
variable "role" {
  description = "(Required) The ARN of the IAM role for Amazon S3 to assume when replicating the objects."
  type        = string
}

variable "rules" {
  description = "(Required) Specifies the rules managing the replication (documented below)."
  type        = string
}

#------------------------------------------------------------------------------
# Rules object variables
#------------------------------------------------------------------------------
variable "rules_id" {
  description = "(Optional) Unique identifier for the rule. Must be less than or equal to 255 characters in length."
  type        = string
  default     = "/"
}

variable "priority" {
  description = "(Optional) The priority associated with the rule."
  type        = string
  default     = "/"
}

variable "destination" {
  description = "(Required) Specifies the destination for the rule (documented below)."
  type        = string
}

variable "source_selection_criteria" {
  description = "(Optional) Specifies special object selection criteria (documented below)."
  type        = string
  default     = "/"
}

variable "rules_prefix" {
  description = "(Optional) Object keyname prefix identifying one or more objects to which the rule applies. Must be less than or equal to 1024 characters in length."
  type        = string
  default     = "/"
}

variable "status" {
  description = "(Required) The status of the rule. Either Enabled or Disabled. The rule is ignored if status is not Enabled."
  type        = string
}

variable "filter" {
  description = "(Optional) Filter that identifies subset of objects to which the replication rule applies (documented below)."
  type        = string
  default     = "/"
}

#------------------------------------------------------------------------------
# Destination object variables
#------------------------------------------------------------------------------
variable "destination_bucket" {
  description = "(Required) The ARN of the S3 bucket where you want Amazon S3 to store replicas of the object identified by the rule."
  type        = string
}

variable "destination_storage_class" {
  description = "(Optional) The class of storage used to store the object. Can be STANDARD, REDUCED_REDUNDANCY, STANDARD_IA, ONEZONE_IA, INTELLIGENT_TIERING, GLACIER, or DEEP_ARCHIVE."
  type        = string
  default     = "/"
}

variable "replica_kms_key_id" {
  description = "(Optional) Destination KMS encryption key ARN for SSE-KMS replication. Must be used in conjunction with sse_kms_encrypted_objects source selection criteria."
  type        = string
  default     = "/"
}

variable "access_control_translation" {
  description = "(Optional) Specifies the overrides to use for object owners on replication. Must be used in conjunction with account_id owner override configuration."
  type        = string
  default     = "/"
}

variable "account_id" {
  description = "(Optional) The Account ID to use for overriding the object owner on replication. Must be used in conjunction with access_control_translation override configuration."
  type        = string
  default     = "/"
}

#------------------------------------------------------------------------------
# Source_selection_criteria object variables
#------------------------------------------------------------------------------
variable "sse_kms_encrypted_objects" {
  description = "(Optional) Match SSE-KMS encrypted objects (documented below). If specified, replica_kms_key_id in destination must be specified as well."
  type        = string
  default     = "/"
}

#------------------------------------------------------------------------------
# Sse_kms_encrypted_objects object variables
#------------------------------------------------------------------------------
variable "sse_kms_encrypted_objects_enabled" {
  description = "(Required) Boolean which indicates if this criteria is enabled."
  type        = bool
}

#------------------------------------------------------------------------------
# Filter object variables
#------------------------------------------------------------------------------
variable "filter_prefix" {
  description = "(Optional) Object keyname prefix that identifies subset of objects to which the rule applies. Must be less than or equal to 1024 characters in length."
  type        = string
  default     = "/"
}

variable "filter_tags" {
  description = "(Optional) A map of tags that identifies subset of objects to which the rule applies. The rule applies only to objects having all the tags in its tagset."
  type        = map(string)
  default = {
    Environment = "dev",
    App         = "phoenix",
    Name        = "phoenix-s3-bucket-lfilter",
    Terrafom    = true
  }
}

#------------------------------------------------------------------------------
# Server_side_encryption_configuration object variables
#------------------------------------------------------------------------------
variable "server_side_encryption_configuration_rule" {
  description = "(Required) A single object for server-side encryption by default configuration. (documented below)."
  type        = string
}

#------------------------------------------------------------------------------
# Rule object variables
#------------------------------------------------------------------------------
variable "apply_server_side_encryption_by_default" {
  description = "(Required) A single object for setting server-side encryption by default. (documented below)."
  type        = string
}

#------------------------------------------------------------------------------
# Apply_server_side_encryption_by_default object variables
#------------------------------------------------------------------------------
#ToDo Check: CKV_AWS_145: "Ensure that S3 buckets are encrypted with KMS by default"
variable "sse_algorithm" {
  description = "(Required) The server-side encryption algorithm to use. Valid values are AES256 and aws:kms."
  type        = string
  //  default     = "AES256"
  default = "aws:kms"
}

#ToDo Check: CKV_AWS_145: "Ensure that S3 buckets are encrypted with KMS by default"
variable "kms_master_key_id" {
  description = "(Optional) The AWS KMS master key ID used for the SSE-KMS encryption. This can only be used when you set the value of sse_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse_algorithm is aws:kms."
  type        = string
  default     = "aws/s3"
}

#------------------------------------------------------------------------------
# Grant object variables
#------------------------------------------------------------------------------
variable "grant_id" {
  description = "(Optional) Canonical user id to grant for. Used only when type is CanonicalUser."
  type        = string
  default     = "/"
}

variable "grant_type" {
  description = "(Required) Type of grantee to apply for. Valid values are CanonicalUser and Group. AmazonCustomerByEmail is not supported."
  type        = string
}

variable "grant_permissions" {
  description = "(Required) List of permissions to apply for grantee. Valid values are READ, WRITE, READ_ACP, WRITE_ACP, FULL_CONTROL."
  type        = list(string)
}

variable "grant_uri" {
  description = "(Optional) Uri address to grant for. Used only when type is Group."
  type        = string
  default     = "/"
}

#------------------------------------------------------------------------------
# Access_control_translation object variables
#------------------------------------------------------------------------------
variable "owner" {
  description = "(Required) The override value for the owner on replicated objects. Currently only Destination is supported."
  type        = string
}

#------------------------------------------------------------------------------
# Object_lock_configuration object variables
#------------------------------------------------------------------------------
variable "object_lock_enabled" {
  description = "(Required) Indicates whether this bucket has an Object Lock configuration enabled. Valid value is Enabled."
  type        = string
}

variable "object_lock_rule" {
  description = "(Optional) The Object Lock rule in place for this bucket."
  type        = string
  default     = "/"
}

#------------------------------------------------------------------------------
# Rule object variables
#------------------------------------------------------------------------------
variable "default_retention" {
  description = "(Required) The default retention period that you want to apply to new objects placed in this bucket."
  type        = string
}

#------------------------------------------------------------------------------
# Default_retention object variables
#------------------------------------------------------------------------------
variable "mode" {
  description = "(Required) The default Object Lock retention mode you want to apply to new objects placed in this bucket. Valid values are GOVERNANCE and COMPLIANCE."
  type        = string
}

variable "default_retention_days" {
  description = "(Optional) The number of days that you want to specify for the default retention period."
  type        = number
  default     = 20
}

variable "default_retention_years" {
  description = "(Optional) The number of years that you want to specify for the default retention period."
  type        = number
  default     = 1
}

#------------------------------------------------------------------------------
# ETC variables
#------------------------------------------------------------------------------
variable "expiration" {
  description = "(Optional) Specifies a period in the object's expire (documented below)."
  type        = string
  default     = "/"
}

variable "transition" {
  description = "(Optional) Specifies a period in the object's transitions (documented below)."
  type        = string
  default     = "/"
}

variable "noncurrent_version_expiration" {
  description = "(Optional) Specifies when noncurrent object versions expire (documented below)."
  type        = string
  default     = "/"
}

variable "noncurrent_version_transition" {
  description = "(Optional) Specifies when noncurrent object versions transitions (documented below)."
  type        = string
  default     = "/"
}

variable "replication_configuration" {
  description = "(Optional) Replication configuration."
  type        = string
  default     = ""
}

variable "destination_replica_bucket_arn" {
  description = "(Optional) Destination bucket arn for replica."
  type        = string
  default     = "arn"
}
