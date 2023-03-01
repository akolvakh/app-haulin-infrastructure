locals {
  role_name = "${var.function_name}-role"
}

# Add Lambda Assume Role
data "aws_iam_policy_document" "lambda_trust_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = distinct(concat(slice(["lambda.amazonaws.com", "edgelambda.amazonaws.com"], 0, var.lambda_at_edge ? 2 : 1), var.trusted_entities))
    }
  }
}

resource "aws_iam_role" "lambda" {
  count              = var.create_role ? 1 : 0
  name               = local.role_name
  path               = var.function_role_path
  assume_role_policy = data.aws_iam_policy_document.lambda_trust_policy.json
}

resource "aws_iam_role_policy_attachment" "terraform_lambda_policy" {
  count      = var.create_role ? 1 : 0
  role       = aws_iam_role.lambda[count.index].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Add Role for XRay Tracing
data "aws_iam_policy" "tracing" {
  count = var.lambda_at_edge ? 0 : 1 #lambda@edge doesn't support xray
  arn   = "arn:aws:iam::aws:policy/AWSXrayWriteOnlyAccess"
}

resource "aws_iam_policy" "tracing" {
  count  = var.lambda_at_edge ? 0 : 1
  name   = "${local.role_name}-tracing"
  policy = data.aws_iam_policy.tracing[count.index].policy
}

resource "aws_iam_policy_attachment" "tracing" {
  count      = var.lambda_at_edge ? 1 : 0
  name       = "${local.role_name}-tracing"
  roles      = [aws_iam_role.lambda[count.index].name]
  policy_arn = aws_iam_policy.tracing[count.index].arn
}

# Copying AWS managed policy to be able to attach the same policy with multiple roles without overwrites by another function
data "aws_iam_policy" "vpc" {
  count = var.lambda_at_edge ? 0 : 1
  arn   = "arn:aws:iam::aws:policy/service-role/AWSLambdaENIManagementAccess"
}

resource "aws_iam_policy" "vpc" {
  count  = var.lambda_at_edge ? 0 : 1
  name   = "${local.role_name}-vpc"
  policy = data.aws_iam_policy.vpc[count.index].policy
}

resource "aws_iam_policy_attachment" "vpc" {
  count      = var.lambda_at_edge ? 1 : 0
  name       = "${local.role_name}-vpc"
  roles      = [aws_iam_role.lambda[count.index].name]
  policy_arn = aws_iam_policy.vpc[count.index].arn
}
