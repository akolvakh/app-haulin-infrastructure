############################################################################
# CodePipeline
############################################################################

resource "aws_iam_role" "default" {
  name               = var.codepipeline_label
  assume_role_policy = data.aws_iam_policy_document.assume_role_code_pipeline.json

  tags = merge(
    var.tags,
    {
      Description = "Base IAM role for CodePipeline"
    },
    {
      Parent = "CodePipeline label: ${var.codepipeline_label}"
    }
  )

  inline_policy {
    name   = "s3"
    policy = data.aws_iam_policy_document.s3.json
  }

  inline_policy {
    name   = "codebuild"
    policy = data.aws_iam_policy_document.codebuild.json
  }

  inline_policy {
    name   = "codestar"
    policy = data.aws_iam_policy_document.codestar.json
  }
}

data "aws_iam_policy_document" "assume_role_code_pipeline" {
  statement {
    sid = ""

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "s3" {

  statement {
    sid = ""

    actions = [
      "s3:*"
    ]

    resources = [
      join("", aws_s3_bucket.artifact_store.*.arn),
      "${join("", aws_s3_bucket.artifact_store.*.arn)}/*"
    ]

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "codebuild" {
  statement {
    sid = ""

    actions = [
      "codebuild:*"
    ]

    resources = [
      "arn:aws:codebuild:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:project/${var.codepipeline_label}*"
    ]
    effect = "Allow"
  }
}

data "aws_iam_policy_document" "codestar" {
  statement {
    sid = ""

    actions = [
      "codestar-connections:UseConnection",
      "codestar-connections:GetConnection",
    ]

    resources = [
      var.gh_connection_arn
    ]
    effect = "Allow"
  }
}

############################################################################
# CodeBuild
############################################################################
resource "aws_iam_role" "codebuild_role" {
  name               = "${var.codepipeline_label}-codebuild"
  assume_role_policy = data.aws_iam_policy_document.assume_role_code_build.json

  tags = merge(
    var.tags,
    {
      Description = "Base IAM role for ${var.codepipeline_label}-build AWS CodeBuild project"
    },
    {
      Parent = "CodePipeline label: ${var.codepipeline_label}"
    }
  )

  inline_policy {
    name   = "cloud_watch"
    policy = data.aws_iam_policy_document.cloud_watch.json
  }

  inline_policy {
    name   = "code_build_s3"
    policy = data.aws_iam_policy_document.code_build_s3.json
  }

  inline_policy {
    name   = "codestar"
    policy = data.aws_iam_policy_document.codestar.json
  }
}

data "aws_iam_policy_document" "assume_role_code_build" {
  statement {
    sid = ""

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "cloud_watch" {
  statement {
    sid = ""

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:${var.codepipeline_label}-build-log_group:*",
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:${var.codepipeline_label}-build-log_group",
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:${var.codepipeline_label}-checkout-log_group:*",
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:${var.codepipeline_label}-checkout-log_group"
    ]
    effect = "Allow"
  }
}

data "aws_iam_policy_document" "code_build_s3" {
  statement {
    sid = ""

    actions = [
      "s3:*"
    ]

    resources = [
      "arn:aws:s3:::${join("", aws_s3_bucket.artifact_store.*.bucket)}",
      "arn:aws:s3:::${join("", aws_s3_bucket.artifact_store.*.bucket)}/*"
    ]
    effect = "Allow"
  }
}

############################################################################
# CodeBuild terraform command
############################################################################

resource "aws_iam_role" "tf_command_codebuild_role" {
  name               = substr("${var.codepipeline_label}-cb-tf-command", 0, 64)
  assume_role_policy = data.aws_iam_policy_document.assume_role_tf_command_code_build.json

  tags = merge(
    var.tags,
    {
      Description = "Base IAM role for ${var.codepipeline_label}-tf-command-build AWS CodeBuild project"
    },
    {
      Parent = "CodePipeline label: ${var.codepipeline_label}"
    }
  )

  inline_policy {
    name   = "cloud_watch_for_tf_command_build"
    policy = data.aws_iam_policy_document.cloud_watch_for_tf_command_build.json
  }

  inline_policy {
    name   = "code_build_s3_tf_states"
    policy = data.aws_iam_policy_document.code_build_s3_tf_states.json
  }

  inline_policy {
    name   = "tf_bucket_replication"
    policy = data.aws_iam_policy_document.tf_bucket_replication.json
  }

  inline_policy {
    name   = "appsync_access"
    policy = data.aws_iam_policy_document.appsync_access.json
  }

  inline_policy {
    name   = "s3"
    policy = data.aws_iam_policy_document.s3.json
  }

  inline_policy {
    name   = "dynamodb_tf_state_access"
    policy = data.aws_iam_policy_document.dynamodb_tf_state_access.json
  }

  inline_policy {
    name   = "waf"
    policy = data.aws_iam_policy_document.waf.json
  }

  inline_policy {
    name   = "iam"
    policy = data.aws_iam_policy_document.iam.json
  }

  inline_policy {
    name   = "ssm"
    policy = data.aws_iam_policy_document.ssm.json
  }
}

data "aws_iam_policy_document" "assume_role_tf_command_code_build" {
  statement {
    sid = ""

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "cloud_watch_for_tf_command_build" {
  statement {
    sid = ""

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:${var.codepipeline_label}-tf-command-build-log_group:*",
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:${var.codepipeline_label}-tf-command-build-log_group"
    ]
    effect = "Allow"
  }
}

data "aws_iam_policy_document" "code_build_s3_tf_states" {
  statement {
    sid = ""

    actions = [
      "s3:*Object*",
    ]

    resources = [
      "arn:aws:s3:::phoenix-tfstate-${var.aws_backend_region}*"
    ]
    effect = "Allow"
  }
  statement {
    sid = ""

    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::phoenix-tfstate-${var.aws_backend_region}*"
    ]
    effect = "Allow"
  }
}

data "aws_iam_policy_document" "dynamodb_tf_state_access" {
  statement {
    sid = ""

    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:CreateTable",
      "dynamodb:Delete*",
      "dynamodb:Update*",
      "dynamodb:PutItem",
      "dynamodb:Get*"
    ]

    resources = [
      "arn:aws:dynamodb:${var.aws_backend_region}:${data.aws_caller_identity.current.account_id}:table/phoenix-tfstate-*"
    ]
    effect = "Allow"
  }
}

data "aws_iam_policy_document" "tf_bucket_replication" {
  statement {
    sid = ""

    actions = [
      "iam:CreateRole",
      "iam:GetRole"
    ]

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/tfstate-*-replicationRole"
    ]
    effect = "Allow"
  }

  statement {
    sid = ""

    actions = [
      "s3:GetReplicationConfiguration"
    ]

    resources = [
      "arn:aws:s3:::phoenix-tfstate-${var.aws_backend_region}*"
    ]

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "appsync_access" {
  statement {
    sid = ""

    actions = [
      "appsync:GetSchemaCreationStatus",
      "appsync:StartSchemaCreation",
      "appsync:GetGraphqlApi",
      "appsync:GetDataSource",
      "appsync:TagResource",
      "appsync:UpdateGraphqlApi",
      "appsync:DeleteResolver",
      "appsync:UpdateResolver",
      "appsync:CreateResolver",
      "appsync:GetResolver",
      "appsync:ListResolvers"
    ]

    resources = [
      "*"
    ]
    effect = "Allow"
  }
}

data "aws_iam_policy_document" "waf" {
  statement {
    sid = ""

    actions = [
      "wafv2:ListTagsForResource",
      "wafv2:GetWebACL",
      "wafv2:TagResource"
    ]

    resources = [
      "arn:aws:wafv2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:regional/webacl/${var.product_name}-${var.environment}-app/*",
      "arn:aws:wafv2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:regional/webacl/${var.product_name}-${var.environment}-admin/*"
    ]
  }

  statement {
    sid = ""

    actions = [
      "wafv2:GetIPSet",
      "wafv2:UpdateIPSet",
      "wafv2:ListTagsForResource",
      "wafv2:TagResource"
    ]

    resources = [
      "arn:aws:wafv2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:regional/ipset/admin/*",
      "arn:aws:wafv2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:regional/ipset/app/*"
    ]
  }

  statement {
    sid = ""

    actions = [
      "wafv2:GetWebACLForResource",
    ]

    resources = [
      "arn:aws:wafv2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:regional/webacl/*"
    ]
  }
}

data "aws_iam_policy_document" "iam" {
  statement {
    sid = ""

    actions = [
      "iam:GetRole",
      "iam:ListRolePolicies",
      "iam:ListAttachedRolePolicies",
      "iam:TagRole",
      "iam:PassRole"
    ]

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/phoenix_admin_*-logs",
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/phoenix_be_*-logs"
    ]
  }
}
