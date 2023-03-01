data "aws_default_tags" "default" {}
data "aws_caller_identity" "current" {}
data "aws_iam_session_context" "ctx" {
  arn = data.aws_caller_identity.current.arn
}
