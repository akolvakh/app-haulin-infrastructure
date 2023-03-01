############################################################################
# CodePipeline
############################################################################

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
    sid = ""

    actions = [
      "s3:*"
    ]

    resources = [
      module.s3_bucket.s3_bucket_arn,
      "${module.s3_bucket.s3_bucket_arn}/*"
    ]

    effect = "Allow"
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
      "arn:aws:codebuild:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:project/${var.codepipeline_label}*"
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


############################################################################
# CodeBuild
############################################################################
resource "aws_iam_role" "codebuild_role" {
  name               = "${var.codepipeline_label}-codebuild"
  assume_role_policy = data.aws_iam_policy_document.assume_role_code_build.json
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

resource "aws_iam_policy" "ecr" {
  name   = "${var.codepipeline_label}-build_to_related_ecr_rw_access"
  policy = data.aws_iam_policy_document.ecr.json
}

data "aws_iam_policy_document" "ecr" {
  statement {
    sid = ""

    actions = [
      "ecr:UntagResource",
      "ecr:TagResource",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "ecr:ListTagsForResource",
      "ecr:DescribeImageScanFindings",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage"
    ]

    resources = [
      "arn:aws:ecr:${var.ecr_region}:${var.ecr_account_id}:repository/${var.product_name}_${var.service_name}",
      "arn:aws:ecr:${var.ecr_region}:${var.ecr_account_id}:repository/tools_*",
      "arn:aws:ecr:${var.ecr_region}:${var.ecr_account_id}:repository/*"
    ]
    effect = "Allow"
  }
}

resource "aws_iam_role_policy_attachment" "ecr" {
  role       = join("", aws_iam_role.codebuild_role.*.id)
  policy_arn = join("", aws_iam_policy.ecr.*.arn)
}

resource "aws_iam_policy" "ecr_auth" {
  name   = "${var.codepipeline_label}_build_ecr_auth"
  policy = data.aws_iam_policy_document.ecr_auth.json
}

data "aws_iam_policy_document" "ecr_auth" {
  statement {
    sid = ""

    actions = [
      "ecr:GetAuthorizationToken"
    ]

    resources = [
      "*"
    ]
    effect = "Allow"
  }
}

resource "aws_iam_role_policy_attachment" "ecr_auth" {
  role       = join("", aws_iam_role.codebuild_role.*.id)
  policy_arn = join("", aws_iam_policy.ecr_auth.*.arn)
}

resource "aws_iam_policy" "cloud_watch" {
  name   = "${var.codepipeline_label}-build_to_cloudwatch_for_child_log_groups_rw_access"
  policy = data.aws_iam_policy_document.cloud_watch.json
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

resource "aws_iam_role_policy_attachment" "cloud_watch" {
  role       = join("", aws_iam_role.codebuild_role.*.id)
  policy_arn = join("", aws_iam_policy.cloud_watch.*.arn)
}

resource "aws_iam_policy" "code_build_s3" {
  name   = "${var.codepipeline_label}_build_to_artifact_store_s3_rw_access"
  policy = data.aws_iam_policy_document.code_build_s3.json
}

data "aws_iam_policy_document" "code_build_s3" {
  statement {
    sid = ""

    actions = [
      "s3:*"
    ]

    resources = [
      "arn:aws:s3:::${module.s3_bucket.s3_bucket_bucket}",
      "arn:aws:s3:::${module.s3_bucket.s3_bucket_bucket}/*"
    ]
    effect = "Allow"
  }
}

resource "aws_iam_role_policy_attachment" "code_build_s3" {
  role       = join("", aws_iam_role.codebuild_role.*.id)
  policy_arn = join("", aws_iam_policy.code_build_s3.*.arn)
}

resource "aws_iam_role_policy_attachment" "code_star" {
  role       = join("", aws_iam_role.codebuild_role.*.id)
  policy_arn = join("", aws_iam_policy.codestar.*.arn)
}

############################################################################
# CodeBuild terraform command
############################################################################

resource "aws_iam_role" "tf_command_codebuild_role" {
  name               = substr("${var.codepipeline_label}-codebuild-tf-command", 0, 64)
  assume_role_policy = data.aws_iam_policy_document.assume_role_tf_command_code_build.json
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

resource "aws_iam_role_policy_attachment" "codestar_for_tf_command_build" {
  role       = join("", aws_iam_role.tf_command_codebuild_role.*.id)
  policy_arn = join("", aws_iam_policy.codestar.*.arn)
}

resource "aws_iam_policy" "cloud_watch_for_tf_command_build" {
  name   = "${var.codepipeline_label}-tf-command-build_to_cloudwatch_for_child_log_groups_rw_access"
  policy = data.aws_iam_policy_document.cloud_watch_for_tf_command_build.json
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

resource "aws_iam_role_policy_attachment" "cloud_watch_for_tf_command_build" {
  role       = join("", aws_iam_role.tf_command_codebuild_role.*.id)
  policy_arn = join("", aws_iam_policy.cloud_watch_for_tf_command_build.*.arn)
}

resource "aws_iam_role_policy_attachment" "s3_tf_for_tf_command_build" {
  role       = join("", aws_iam_role.tf_command_codebuild_role.*.id)
  policy_arn = join("", aws_iam_policy.s3.*.arn)
}

resource "aws_iam_policy" "code_build_s3_tf_states" {
  name   = "${var.codepipeline_label}_build_to_s3_tf_states_rw_access"
  policy = data.aws_iam_policy_document.code_build_s3_tf_states.json
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

resource "aws_iam_role_policy_attachment" "code_build_s3_tf_states" {
  role       = join("", aws_iam_role.tf_command_codebuild_role.*.id)
  policy_arn = join("", aws_iam_policy.code_build_s3_tf_states.*.arn)
}

resource "aws_iam_policy" "dynamodb_tf_state_access" {
  name   = "${var.codepipeline_label}_build_to_dynamodb_tf_states_rw_access"
  policy = data.aws_iam_policy_document.dynamodb_tf_state_access.json
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

resource "aws_iam_role_policy_attachment" "dynamodb_tf_state_access" {
  role       = join("", aws_iam_role.tf_command_codebuild_role.*.id)
  policy_arn = join("", aws_iam_policy.dynamodb_tf_state_access.*.arn)
}

resource "aws_iam_role_policy_attachment" "ec2_ro" {
  role       = join("", aws_iam_role.tf_command_codebuild_role.*.id)
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

resource "aws_iam_policy" "ecs_service_deploy" {
  name   = "${var.codepipeline_label}_build_to_ecs_service_deploy_access"
  policy = data.aws_iam_policy_document.ecs_service_deploy.json
}

data "aws_iam_policy_document" "ecs_service_deploy" {
  statement {
    sid = ""

    actions = [
      "ecs:UpdateService",
      "ecs:StopTask",
      "ecs:DescribeServices",
      "ecs:DescribeTasks",
      "ecs:DescribeClusters",
      "ecs:CreateService",
      "ecs:DeleteService",
      "ecs:TagResource",
      "ecs:UntagResource"
    ]

    resources = [
      "arn:aws:ecs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:cluster/${var.ecs_cluster_name}",
      "arn:aws:ecs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:task-definition/${var.product_name}*",
      "arn:aws:ecs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:task/*",
      "arn:aws:ecs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:service/${var.ecs_cluster_name}/*"
    ]
    effect = "Allow"
  }
  statement {
    sid = "AllowServiceDiscoveryActions"

    actions = [
      "servicediscovery:CreateService",
      "servicediscovery:TagResource",
      "servicediscovery:GetService",
      "servicediscovery:ListTagsForResource",
      "servicediscovery:DeleteService"
    ]

    resources = [
      "arn:aws:servicediscovery:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"
    ]
    effect = "Allow"
  }
  statement {
    sid = ""

    actions = [
      "ecs:DeregisterTaskDefinition",
      "ecs:RegisterTaskDefinition",
      "ecs:ListTaskDefinitions",
      "ecs:DescribeTaskDefinition",
      "ecs:ListClusters"
    ]

    resources = [
      "*"
    ]
    effect = "Allow"
  }

  statement {
    sid = "AllowResourceChangeManagmentTracking"

    actions = [
      "ssm:PutParameter",
      "ssm:AddTagsToResource",
      "ssm:GetParameters",
      "ssm:GetParameter",
      "ssm:DescribeParameters",
      "ssm:ListTagsForResource",
      "ssm:DeleteParameter"
    ]
    resources = ["arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/${var.product_name}/${var.environment}/deployments/*"]
  }

  statement {
    sid = "AllowResourceChangeManagmentTrackingDescribe"

    actions = [
      "ssm:DescribeParameters"
    ]
    resources = ["arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"]
  }

  #Autoscaling policies

  # The Resource element specifies the object or objects to which the action applies.
  # Application Auto Scaling has no service-defined resources that can be used as the Resource element of an IAM policy statement. 
  # Therefore, there are no Amazon Resource Names (ARNs) for Application Auto Scaling for you to use in an IAM policy. 
  # To control access to Application Auto Scaling API actions, always use an * (asterisk) as the resource when writing an IAM policy.
  # https://github.com/awsdocs/application-auto-scaling-user-guide/blob/master/doc_source/security_iam_service-with-iam.md
  statement {
    sid = "AllowAutoscalingForECS"

    actions = [
      "application-autoscaling:DeregisterScalableTarget",
      "application-autoscaling:DescribeScalableTargets",
      "application-autoscaling:DescribeScalingActivities",
      "application-autoscaling:DescribeScalingPolicies",
      "application-autoscaling:DescribeScheduledActions",
      "application-autoscaling:PutScalingPolicy",
      "application-autoscaling:PutScheduledAction",
      "application-autoscaling:RegisterScalableTarget"
    ]

    resources = [
      "*"
    ]
    effect = "Allow"
  }

  statement {
    sid = "CreateServiceLinkedRole"

    actions = [
      "iam:CreateServiceLinkedRole",
    ]

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/ecs.application-autoscaling.amazonaws.com/AWSServiceRoleForApplicationAutoScaling_ECSService"
    ]
    condition {
      test     = "StringLike"
      variable = "iam:AWSServiceName"
      values   = ["ecs.application-autoscaling.amazonaws.com"]

    }
    effect = "Allow"
  }
}

resource "aws_iam_role_policy_attachment" "ecs_service_deploy" {
  role       = join("", aws_iam_role.tf_command_codebuild_role.*.id)
  policy_arn = join("", aws_iam_policy.ecs_service_deploy.*.arn)
}

resource "aws_iam_policy" "iam_pass_role" {
  name   = "${var.codepipeline_label}_build_pass_iam_role_on_ecs_service_role"
  policy = data.aws_iam_policy_document.iam_pass_role.json
}

data "aws_iam_policy_document" "iam_pass_role" {
  statement {
    sid = ""

    actions = [
      "iam:PassRole"
    ]

    resources = [
      "${var.task_execution_role_arn}",
      "${var.task_role_arn}",
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/ecs.application-autoscaling.amazonaws.com/AWSServiceRoleForApplicationAutoScaling_ECSService"
    ]
    effect = "Allow"
  }
}

resource "aws_iam_role_policy_attachment" "iam_pass_role" {
  role       = join("", aws_iam_role.tf_command_codebuild_role.*.id)
  policy_arn = join("", aws_iam_policy.iam_pass_role.*.arn)
}

resource "aws_iam_policy" "tf_bucket_replication" {
  name   = "${var.codepipeline_label}_build_tf_state_bucket_replication"
  policy = data.aws_iam_policy_document.tf_bucket_replication.json
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

resource "aws_iam_role_policy_attachment" "tf_bucket_replication" {
  role       = join("", aws_iam_role.tf_command_codebuild_role.*.id)
  policy_arn = join("", aws_iam_policy.tf_bucket_replication.*.arn)
}
