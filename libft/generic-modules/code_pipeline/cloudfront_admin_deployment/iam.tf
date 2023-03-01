resource "aws_iam_role" "default" {
  name               = var.codepipeline_label
  assume_role_policy = data.aws_iam_policy_document.assume_role_code_pipeline.json
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

resource "aws_iam_policy" "s3" {
  name   = "${var.codepipeline_label}_to_s3_artifact_store_full_access"
  policy = join("", data.aws_iam_policy_document.s3.*.json)
}

data "aws_iam_policy_document" "s3" {
  statement {
    actions = [
      "s3:CreateBucket",
      "s3:GetObject",
      "s3:List*",
      "s3:PutObject"
    ]

    resources = [
      module.s3_bucket.s3_bucket_arn,
      "${module.s3_bucket.s3_bucket_arn}/*"
    ]
  }
}

resource "aws_iam_role_policy_attachment" "s3" {
  role       = join("", aws_iam_role.default.*.id)
  policy_arn = join("", aws_iam_policy.s3.*.arn)
}

resource "aws_iam_policy" "codebuild" {
  name   = "${var.codepipeline_label}_to_child_codebuild_projects_full_access"
  policy = data.aws_iam_policy_document.codebuild.json
}

data "aws_iam_policy_document" "codebuild" {
  statement {
    sid = ""

    actions = [
      "codebuild:*"
    ]

    resources = [
      "arn:aws:codebuild:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:project/${var.codebuild_project_name}*",
      aws_codebuild_project.checkout.arn,
      "${aws_codebuild_project.checkout.arn}/*"
    ]
    effect = "Allow"
  }
}

resource "aws_iam_role_policy_attachment" "codebuild" {
  role       = join("", aws_iam_role.default.*.id)
  policy_arn = join("", aws_iam_policy.codebuild.*.arn)
}

resource "aws_iam_policy" "codestar" {
  name   = "${var.codepipeline_label}_to_codestar_use_connection_access"
  policy = data.aws_iam_policy_document.codestar.json
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

resource "aws_iam_role_policy_attachment" "codestar" {
  role       = join("", aws_iam_role.default.*.id)
  policy_arn = join("", aws_iam_policy.codestar.*.arn)
}
