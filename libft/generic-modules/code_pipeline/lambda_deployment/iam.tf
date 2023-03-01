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


###
resource "aws_iam_policy" "s3" {
  name   = "${var.codepipeline_label}_to_s3_artifact_store_full_access"
  policy = join("", data.aws_iam_policy_document.s3.*.json)

  tags = merge(
    var.tags,
    {
      Description = "IAM policy for ${join("", aws_iam_role.default.*.id)} to allow AWS S3 API calling"
    },
    {
      Parent = "CodePipeline label: ${var.codepipeline_label}"
    }
  )
}

data "aws_iam_policy_document" "s3" {

  statement {
    sid = ""

    actions = [
      "s3:CreateBucket",
      "s3:PutObject",
      "s3:ListObjects",
      "s3:ListBucket",
      "s3:GetObjectVersion",
      "s3:GetObject",
      "s3:GetBucketLocation"
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


###
resource "aws_iam_policy" "codebuild" {
  name   = "${var.codepipeline_label}_to_child_codebuild_projects_full_access"
  policy = data.aws_iam_policy_document.codebuild.json

  tags = merge(
    var.tags,
    {
      Description = "IAM policy for ${join("", aws_iam_role.default.*.id)} to allow AWS CodeBuild API calling"
    },
    {
      Parent = "CodePipeline label: ${var.codepipeline_label}"
    }
  )
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


###
resource "aws_iam_policy" "codestar" {
  name   = "${var.codepipeline_label}_to_codestar_use_connection_access"
  policy = data.aws_iam_policy_document.codestar.json

  tags = merge(
    var.tags,
    {
      Description = "IAM policy for ${join("", aws_iam_role.default.*.id)} to allow AWS ECS API calling"
    },
    {
      Parent = "CodePipeline label: ${var.codepipeline_label}"
    }
  )
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

  tags = merge(
    var.tags,
    {
      Description = "Base IAM role for ${var.codepipeline_label}-build AWS CodeBuild project"
    },
    {
      Parent = "CodePipeline label: ${var.codepipeline_label}"
    }
  )
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


###
resource "aws_iam_policy" "ecr" {
  name   = "${var.codepipeline_label}-build_to_related_ecr_rw_access"
  policy = data.aws_iam_policy_document.ecr.json

  tags = merge(
    var.tags,
    {
      Description = "IAM policy for ${join("", aws_iam_role.codebuild_role.*.id)} to allow AWS ECR API calling"
    },
    {
      Parent = "CodePipeline label: ${var.codepipeline_label}"
    }
  )
}

data "aws_iam_policy_document" "ecr" {

  #ECR permissions
  statement {
    sid = "EcrAccess"

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
      "ecr:PutImage",
      "ecr:GetAuthorizationToken",
    ]

    resources = [
      "${var.lambda_ecr_arns["cognito_preauthorization_lambda"]}",
      "${var.lambda_ecr_arns["cognito_presignup_lambda"]}",
      "${var.lambda_ecr_arns["codepipeline_slack_integration_lambda"]}",
      "${var.lambda_ecr_arns["cognito_post_confirmation_lambda"]}"
    ]
    effect = "Allow"
  }

  statement {
    sid = "AllowGetAuthorizationToken"
    actions = [
      "ecr:GetAuthorizationToken"
    ]

    resources = [
      "*"
    ]
    effect = "Allow"
  }

}

resource "aws_iam_role_policy_attachment" "ecr" {
  role       = join("", aws_iam_role.codebuild_role.*.id)
  policy_arn = join("", aws_iam_policy.ecr.*.arn)
}


###
resource "aws_iam_role_policy_attachment" "codestar_for_codebuild" {
  role       = join("", aws_iam_role.codebuild_role.*.id)
  policy_arn = join("", aws_iam_policy.codestar.*.arn)
}

###
resource "aws_iam_policy" "code_build_s3" {
  name   = "${var.codepipeline_label}_build_to_artifact_store_s3_rw_access"
  policy = data.aws_iam_policy_document.code_build_s3.json

  tags = merge(
    var.tags,
    {
      Description = "IAM policy for ${join("", aws_iam_role.codebuild_role.*.id)} to allow AWS S3 API calling"
    },
    {
      Parent = "CodePipeline label: ${var.codepipeline_label}"
    }
  )
}

data "aws_iam_policy_document" "code_build_s3" {
  statement {
    sid = ""

    actions = [
      "s3:PutObject",
      "s3:ListObjects",
      "s3:ListBucket",
      "s3:GetObjectVersion",
      "s3:GetObject",
      "s3:GetBucketLocation"
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

###

resource "aws_iam_policy" "parameter_store" {
  name   = "${var.codepipeline_label}_build_parameter_store"
  policy = data.aws_iam_policy_document.parameter_store.json

  tags = merge(
    var.tags,
    {
      Description = "IAM policy for ${join("", aws_iam_role.codebuild_role.*.id)} to allow AWS ECR authentification"
    },
    {
      Parent = "CodePipeline label: ${var.codepipeline_label}"
    }
  )
}

data "aws_iam_policy_document" "parameter_store" {

  #ECR Authorization
  statement {
    sid = "GenericTaskExcutionRoleParameterStore"
    actions = [
      "ssm:GetParameters",
      "ssm:GetParameter"
    ]

    resources = [
      "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/phoenix-app/${var.environment}/shared/ecs/app_certificate_self_signed/p12/*",
      "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/phoenix-app/${var.environment}/shared/ecs/phoenix_local/*"
    ]
    effect = "Allow"
  }

}

resource "aws_iam_role_policy_attachment" "parameter_store" {
  role       = join("", aws_iam_role.codebuild_role.*.id)
  policy_arn = join("", aws_iam_policy.parameter_store.*.arn)
}

############################################################################
# CodeBuild terraform command
############################################################################
###
resource "aws_iam_role" "tf_command_codebuild_role" {
  name               = substr("${var.codepipeline_label}-codebuild-tf-command", 0, 64)
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


###
resource "aws_iam_role_policy_attachment" "s3_tf_for_tf_command_build" {
  role       = join("", aws_iam_role.tf_command_codebuild_role.*.id)
  policy_arn = join("", aws_iam_policy.s3.*.arn)
}


###
resource "aws_iam_policy" "code_build_s3_tf_states" {
  name   = "${var.codepipeline_label}_build_to_s3_tf_states_rw_access"
  policy = data.aws_iam_policy_document.code_build_s3_tf_states.json

  tags = merge(
    var.tags,
    {
      Description = "IAM policy for ${join("", aws_iam_role.codebuild_role.*.id)} to allow AWS S3 API calling"
    },
    {
      Parent = "CodePipeline label: ${var.codepipeline_label}"
    }
  )
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


###
resource "aws_iam_policy" "dynamodb_tf_state_access" {
  name   = "${var.codepipeline_label}_build_to_dynamodb_tf_states_rw_access"
  policy = data.aws_iam_policy_document.dynamodb_tf_state_access.json

  tags = merge(
    var.tags,
    {
      Description = "IAM policy for ${join("", aws_iam_role.codebuild_role.*.id)} to allow AWS DynamoDB API calling"
    },
    {
      Parent = "CodePipeline label: ${var.codepipeline_label}"
    }
  )
}

data "aws_iam_policy_document" "dynamodb_tf_state_access" {

  statement {
    sid = "DynamoDBAccess"

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

resource "aws_iam_policy" "ssm" {
  name   = "${var.codepipeline_label}_build_ssm_lambda_access"
  policy = data.aws_iam_policy_document.ssm.json
}

resource "aws_iam_role_policy_attachment" "dynamodb_tf_state_access" {
  role       = join("", aws_iam_role.tf_command_codebuild_role.*.id)
  policy_arn = join("", aws_iam_policy.dynamodb_tf_state_access.*.arn)
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = join("", aws_iam_role.tf_command_codebuild_role.*.id)
  policy_arn = join("", aws_iam_policy.ssm.*.arn)
}


###
resource "aws_iam_policy" "appconfig" {
  name   = "${var.codepipeline_label}_build_appconfig_to_build_lambda_access"
  policy = data.aws_iam_policy_document.appconfig.json

  tags = merge(
    var.tags,
    {
      Description = "IAM policy for ${join("", aws_iam_role.codebuild_role.*.id)} to have access to build AppConfig for Lambdas"
    },
    {
      Parent = "CodePipeline label: ${var.codepipeline_label}"
    }
  )
}

data "aws_iam_policy_document" "appconfig" {

  # AppConfig
  statement {
    sid = "AppConfigAccess"

    actions = [
      "appconfig:*"
    ]

    resources = [
      "arn:aws:appconfig:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"
    ]
    effect = "Allow"
  }

}

resource "aws_iam_role_policy_attachment" "appconfig" {
  role       = join("", aws_iam_role.tf_command_codebuild_role.*.id)
  policy_arn = join("", aws_iam_policy.appconfig.*.arn)
}


###
resource "aws_iam_role_policy_attachment" "ec2_ro" {
  role       = join("", aws_iam_role.tf_command_codebuild_role.*.id)
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}


###
resource "aws_iam_policy" "tf_bucket_replication" {
  name   = "${var.codepipeline_label}_build_tf_state_bucket_replication"
  policy = data.aws_iam_policy_document.tf_bucket_replication.json

  tags = merge(
    var.tags,
    {
      Description = "IAM policy for ${join("", aws_iam_role.codebuild_role.*.id)} to allow pass ecs service iam role"
    },
    {
      Parent = "CodePipeline label: ${var.codepipeline_label}"
    }
  )
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


###
resource "aws_iam_policy" "cloud_watch" {
  name   = "${var.codepipeline_label}-build_to_cloudwatch_for_child_log_groups_rw_access"
  policy = data.aws_iam_policy_document.cloud_watch.json

  tags = merge(
    var.tags,
    {
      Description = "IAM policy for ${join("", aws_iam_role.codebuild_role.*.id)} to allow cloudwatch API calling"
    },
    {
      Parent = "CodePipeline label: ${var.codepipeline_label}"
    }
  )
}

data "aws_iam_policy_document" "cloud_watch" {
  statement {
    sid = "CloudWatchLogs"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:${var.codepipeline_label}-*"
    ]
    effect = "Allow"
  }
}

resource "aws_iam_role_policy_attachment" "cloud_watch" {
  role       = join("", aws_iam_role.codebuild_role.*.id)
  policy_arn = join("", aws_iam_policy.cloud_watch.*.arn)
}

resource "aws_iam_role_policy_attachment" "cloud_watch_for_tf_command_build" {
  role       = join("", aws_iam_role.tf_command_codebuild_role.*.id)
  policy_arn = join("", aws_iam_policy.cloud_watch.*.arn)
}


###
resource "aws_iam_policy" "lambda_deployments" {
  name   = "${var.codepipeline_label}_build_lambda_deployments"
  policy = data.aws_iam_policy_document.lambda_deployments.json

  tags = merge(
    var.tags,
    {
      Description = "IAM policy for ${join("", aws_iam_role.codebuild_role.*.id)} to allow LambdaDeployments."
    },
    {
      Parent = "CodePipeline label: ${var.codepipeline_label}"
    }
  )
}

data "aws_iam_policy_document" "lambda_deployments" {

  #IAM
  statement {
    sid = "IAMAccess"

    actions = [
      "iam:ListPolicies",
      "iam:ListPolicyVersions",
      "iam:GetRole",
      "iam:GetPolicyVersion",
      "iam:GetPolicy",
      "iam:TagRole",
      "iam:UntagRole",
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:AttachRolePolicy",
      "iam:TagPolicy",
      "iam:CreatePolicy",
      "iam:ListInstanceProfilesForRole",
      "iam:ListAttachedRolePolicies",
      "iam:ListRolePolicies",
      "iam:CreatePolicyVersion",
      "iam:ListEntitiesForPolicy",
      "iam:CreateRole",
      "iam:DeletePolicyVersion",
      "iam:PassRole"
    ]

    #ToDo var.product_name
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/phoenix-app_${var.environment}.cognito_trigger_pre_signup.*",
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/phoenix-app_${var.environment}.cognito_trigger_pre_authorization.*",
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/phoenix-app_${var.environment}.cognito_trigger_post_confirmation.*",
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/phoenix-app-${var.environment}-codepipeline_slack_integration_lambda.*",
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/phoenix-app-${var.environment}-cloudfront_cache_headers_lambda.*",
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/phoenix-app.${var.environment}.*",
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/*",
      "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
      "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess",
      "arn:aws:iam::aws:policy/service-role/AWSLambdaENIManagementAccess"
    ]
    effect = "Allow"
  }

  #VPC Configuration - Network Interface
  statement {
    sid = "AllowEC2NetworkInterfaces"
    actions = [
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:CreateNetworkInterface"
    ]

    resources = [
      "*"
    ]
    effect = "Allow"
  }

  #Lambda
  statement {
    sid = "AllowCreateAndUpdateLambdas"
    actions = [
      "lambda:CreateFunction",
      "lambda:TagResource",
      "lambda:ListVersionsByFunction",
      "lambda:GetLayerVersion",
      "lambda:GetFunctionConfiguration",
      "lambda:GetLayerVersionPolicy",
      "lambda:RemoveLayerVersionPermission",
      "lambda:UntagResource",
      "lambda:DeleteLayerVersion",
      "lambda:ListLayerVersions",
      "lambda:ListLayers",
      "lambda:DeleteFunction",
      "lambda:ListFunctions",
      "lambda:GetFunction",
      "lambda:ListAliases",
      "lambda:UpdateFunctionConfiguration",
      "lambda:AddLayerVersionPermission",
      "lambda:UpdateFunctionCode",
      "lambda:AddPermission",
      "lambda:PublishVersion",
      "lambda:RemovePermission",
      "lambda:GetPolicy"
    ]

    resources = [
      "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:*"
    ]
    effect = "Allow"
  }

  #ECR Get Images
  statement {
    sid = "LambdaECRImageRetrievalPolicy"
    actions = [
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:GetRepositoryPolicy",
      "ecr:SetRepositoryPolicy"
    ]

    #ToDo
    resources = [
      "arn:aws:ecr:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:repository/*"
    ]
    effect = "Allow"
  }

}

resource "aws_iam_role_policy_attachment" "lambda_deployments" {
  role       = join("", aws_iam_role.tf_command_codebuild_role.*.id)
  policy_arn = join("", aws_iam_policy.lambda_deployments.*.arn)
}
