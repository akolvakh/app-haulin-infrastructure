#------------------------------------------------------------------------------
# General
#------------------------------------------------------------------------------
resource "random_string" "suffix" {
  length  = 8
  special = false
}

#------------------------------------------------------------------------------
# SQS queue
#------------------------------------------------------------------------------
resource "aws_sqs_queue" "terraform_queue" {
  name                      = var.name
  delay_seconds             = var.delay_seconds
  max_message_size          = var.max_message_size
  message_retention_seconds = var.message_retention_seconds
  receive_wait_time_seconds = var.receive_wait_time_seconds
  redrive_policy            = var.redrive_policy

  # FIFO queue
  fifo_queue                  = var.fifo_queue
  content_based_deduplication = var.content_based_deduplication

  # Server-side encryption (SSE)
  kms_master_key_id                 = var.kms_master_key_id
  kms_data_key_reuse_period_seconds = var.kms_data_key_reuse_period_seconds

  tags = {
    Name        = "${var.app}-${var.env}-sqs-${random_string.suffix.result}-"
    Terraform   = true
    App         = var.app
    Environment = "${var.app}-${var.env}"
  }
}

#------------------------------------------------------------------------------
# SQS queue policy
#------------------------------------------------------------------------------
resource "aws_sqs_queue_policy" "queue_policy" {
  queue_url = aws_sqs_queue.terraform_queue.id
  policy    = var.sqs_queue_policy_policy
}
