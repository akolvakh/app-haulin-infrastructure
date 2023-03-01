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
# SMS preferences variables
#------------------------------------------------------------------------------
variable "monthly_spend_limit" {
  description = "(Optional) The maximum amount in USD that you are willing to spend each month to send SMS messages."
  type        = string
  default     = ""
}

variable "delivery_status_iam_role_arn" {
  description = "(Optional) The ARN of the IAM role that allows Amazon SNS to write logs about SMS deliveries in CloudWatch Logs."
  type        = string
  default     = ""
}

variable "delivery_status_success_sampling_rate" {
  description = "(Optional) The percentage of successful SMS deliveries for which Amazon SNS will write logs in CloudWatch Logs. The value must be between 0 and 100."
  type        = number
  default     = ""
}

variable "default_sender_id" {
  description = "(Optional) A string, such as your business brand, that is displayed as the sender on the receiving device."
  type        = string
  default     = ""
}

variable "default_sms_type" {
  description = "(Optional) The type of SMS message that you will send by default. Possible values are: Promotional, Transactional."
  type        = string
  default     = ""
}

variable "usage_report_s3_bucket" {
  description = "(Optional) The name of the Amazon S3 bucket to receive daily SMS usage reports from Amazon SNS."
  type        = string
  default     = ""
}
