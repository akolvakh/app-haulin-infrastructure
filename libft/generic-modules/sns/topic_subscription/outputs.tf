#------------------------------------------------------------------------------
# Topic subscription
#------------------------------------------------------------------------------
output "arn" {
  description = "ARN of the subscription."
  value       = aws_sns_topic_subscription.sns_topic_subscription.arn
}

output "id" {
  description = "ARN of the subscription."
  value       = aws_sns_topic_subscription.sns_topic_subscription.id
}

#ToDo
//output "owner_id" {
//  description = "AWS account ID of the subscription's owner."
//  value       = aws_sns_topic_subscription.sns_topic_subscription.owner_id
//}
//
//output "pending_confirmation" {
//  description = "Whether the subscription has not been confirmed."
//  value       = aws_sns_topic_subscription.sns_topic_subscription.pending_confitmation
//}
//
//output "confirmation_was_authenticated" {
//  description = "Whether the subscription confirmation request was authenticated."
//  value       = aws_sns_topic_subscription.sns_topic_subscription.confirmation_was_authenticated
//}
