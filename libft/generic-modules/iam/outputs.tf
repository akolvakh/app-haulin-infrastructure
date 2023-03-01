#------------------------------------------------------------------------------
# AWS ECS Task Execution Role
#------------------------------------------------------------------------------
output "arn" {
  description = "Amazon Resource Name (ARN) specifying the role."
  value       = aws_iam_role.role.arn
}

output "created_date" {
  description = "Creation date of the IAM role."
  value       = aws_iam_role.role.create_date
}

output "id" {
  description = "Name of the role."
  value       = aws_iam_role.role.id
}

output "name" {
  description = "Name of the role."
  value       = aws_iam_role.role.name
}

output "unique_id" {
  description = "Stable and unique string identifying the role."
  value       = aws_iam_role.role.unique_id
}

output "task_execution_role" {
  description = "AWS IAM Role policy attachment for ECS task execution role."
  value       = aws_iam_role_policy_attachment.policy_attachment
}
