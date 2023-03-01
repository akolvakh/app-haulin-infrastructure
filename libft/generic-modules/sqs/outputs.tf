#------------------------------------------------------------------------------
# SQS queue
#------------------------------------------------------------------------------
output "sqs_id" {
  description = "The URL for the created Amazon SQS queue."
  value       = aws_sqs_queue.terraform_queue.id
}

output "sqs_arn" {
  description = "The ARN of the SQS queue."
  value       = aws_sqs_queue.terraform_queue.arn
}
