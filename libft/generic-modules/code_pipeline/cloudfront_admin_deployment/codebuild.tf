locals {
  codebuild_project_name = "${var.codepipeline_label}-checkout"
}

data "aws_iam_policy_document" "codebuild_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "log_stream_and_group" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role" "codebuild" {
  name               = "codebuild-${random_string.random.result}"
  assume_role_policy = data.aws_iam_policy_document.codebuild_assume_role_policy.json

  inline_policy {
    name   = "S3Access"
    policy = data.aws_iam_policy_document.s3.json
  }

  inline_policy {
    name   = "CodeStar"
    policy = data.aws_iam_policy_document.codestar.json
  }

  inline_policy {
    name   = "LogStreamAndGroup"
    policy = data.aws_iam_policy_document.log_stream_and_group.json
  }
}

resource "aws_codebuild_project" "checkout" {
  name          = local.codebuild_project_name
  description   = "Custom checkout step for CodePipelines"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file("${path.module}/buildspec_checkout.yaml")
  }
}
