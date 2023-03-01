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
# SQS queue variables
#------------------------------------------------------------------------------
variable "name" {
  description = "(Optional) This is the human-readable name of the queue. If omitted, Terraform will assign a random name."
  type        = string
  default     = "/"
}
variable "name_prefix" {
  description = "(Optional) Creates a unique name beginning with the specified prefix. Conflicts with name."
  type        = string
  default     = "sqs"
}

variable "visibility_timeout_seconds" {
  description = "(Optional) The visibility timeout for the queue. An integer from 0 to 43200 (12 hours). The default for this attribute is 30. For more information about visibility timeout, see AWS docs."
  type        = number
  default     = 30
}

variable "message_retention_seconds" {
  description = "(Optional) The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days). The default for this attribute is 345600 (4 days)."
  type        = number
  default     = 345600
}

variable "max_message_size" {
  description = "(Optional) The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB). The default for this attribute is 262144 (256 KiB)."
  type        = number
  default     = 262144
}

variable "delay_seconds" {
  description = "(Optional) The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes). The default for this attribute is 0 seconds."
  type        = number
  default     = 0
}

variable "receive_wait_time_seconds" {
  description = "(Optional) The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds). The default for this attribute is 0, meaning that the call will return immediately."
  type        = number
  default     = 0
}

variable "policy" {
  description = "(Optional) The JSON policy for the SQS queue. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide."
  type        = string
  default     = "{}"
}

variable "redrive_policy" {
  description = "(Optional) The JSON policy to set up the Dead Letter Queue, see AWS docs. Note: when specifying maxReceiveCount, you must specify it as an integer (5), and not a string ('5')."
  type        = string
  default     = "{}"
}

variable "fifo_queue" {
  description = "(Optional) Boolean designating a FIFO queue. If not set, it defaults to false making it standard."
  type        = bool
  default     = false
}

variable "content_based_deduplication" {
  description = "(Optional) Enables content-based deduplication for FIFO queues."
  type        = bool
  default     = true
}

variable "kms_master_key_id" {
  description = "(Optional) The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK. For more information, see Key Terms."
  type        = string
  default     = "/"
}

variable "kms_data_key_reuse_period_seconds" {
  description = "(Optional) The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. An integer representing seconds, between 60 seconds (1 minute) and 86,400 seconds (24 hours). The default is 300 (5 minutes)."
  type        = number
  default     = 300
}

variable "tags" {
  description = "(Optional) A map of tags to assign to the queue."
  type        = map(string)
  default = {
    Environment = "dev",
    App         = "phoenix",
    Name        = "phoenix-sqs",
    Terrafom    = true
  }
}

#------------------------------------------------------------------------------
# SQS queue policy vairables
#------------------------------------------------------------------------------
# variable "queue_url" {
#   description = "(Required) The URL of the SQS Queue to which to attach the policy." // That variable not used anywhere but required for module invocation!
#   type        = string
# }

variable "sqs_queue_policy_policy" {
  description = "(Required) The JSON policy for the SQS queue. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide."
  type        = string
}
