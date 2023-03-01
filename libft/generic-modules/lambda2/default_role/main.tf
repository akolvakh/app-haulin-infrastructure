resource "random_id" "role" {
  byte_length = 8
}
resource "random_id" "policy" {
  byte_length = 8
}
data "aws_iam_policy_document" "role_assume" {
  statement {
    sid     = "AllowLambdaAssumeBasicRole"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = distinct(concat(slice(["lambda.amazonaws.com", "edgelambda.amazonaws.com"], 0, var.lambda_at_edge ? 2 : 1), var.trusted_entities))
    }
  }
}
data "aws_iam_policy" "lambdaBasicExecPolicy" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
data "aws_iam_policy" "xray_write" {
  arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
}


resource "aws_iam_role" "role" {
  name               = substr(join(".", [local.name_prefix, "default_lambda_role", random_id.role.dec]), 0, 64)
  assume_role_policy = data.aws_iam_policy_document.role_assume.json
  tags               = merge(local.common_tags, { "role" = "default_lambda_role" })
}

/*
resource "aws_iam_policy" "basic" {
  name        = join(".", [local.name_prefix, "default_lambda_policy", random_id.policy.dec])
  description = "Basic Lambda policy"
  policy      = data.aws_iam_policy_document.lambdaBasicExecPolicy.json
  tags        = merge(local.common_tags, { "role" = "default_lambda_policy" })
}
*/
resource "aws_iam_role_policy_attachment" "basic_attachment" {
  role       = aws_iam_role.role.name
  policy_arn = data.aws_iam_policy.lambdaBasicExecPolicy.arn
}
resource "aws_iam_role_policy_attachment" "xray_write_attachment" {
  role       = aws_iam_role.role.name
  policy_arn = data.aws_iam_policy.xray_write.arn
}


# Copying AWS managed policy to be able to attach the same policy with multiple roles without overwrites by another function
data "aws_iam_policy" "vpc" {
  count = var.lambda_at_edge ? 0 : 1
  arn   = "arn:aws:iam::aws:policy/service-role/AWSLambdaENIManagementAccess"
}

resource "aws_iam_policy" "vpc" {
  count  = var.lambda_at_edge ? 0 : 1
  name   = substr(join(".", [local.name_prefix, "default_vpc_policy", random_id.role.dec]), 0, 64)
  policy = data.aws_iam_policy.vpc[count.index].policy
}

resource "aws_iam_policy_attachment" "vpc" {
  count      = var.lambda_at_edge ? 0 : 1
  name       = substr(join(".", [local.name_prefix, "default_vpc_policy", random_id.role.dec]), 0, 64)
  roles      = [aws_iam_role.role.name]
  policy_arn = aws_iam_policy.vpc[count.index].arn
}