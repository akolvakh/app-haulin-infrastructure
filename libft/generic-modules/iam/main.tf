#ToDo make more generic
#------------------------------------------------------------------------------
# AWS ECS Task Execution Role
#------------------------------------------------------------------------------
resource "aws_iam_role" "role" {
  name               = var.name
  assume_role_policy = var.assume_role_policy
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  count = length(var.policy_arn)

  role       = aws_iam_role.role.name
  policy_arn = element(var.policy_arn, count.index)
}
