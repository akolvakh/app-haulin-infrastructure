resource "aws_codebuild_project" "checkout" {
  name          = "${var.codepipeline_label}-checkout"
  build_timeout = var.build_timeout
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "${var.codepipeline_label}-checkout-log_group"
      stream_name = "${var.codepipeline_label}-checkout-log_stream"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file("${path.module}/tpl/buildspec_checkout.yaml.tpl")
  }

  tags = merge(
    var.tags,
    {
      Description = "CodeBuild project designed to checking out code version"
    },
    {
      Parent = "CodePipeline label: ${var.codepipeline_label}"
    }
  )
}

resource "aws_codebuild_project" "lambda-test-project" {
  name          = "${var.codepipeline_label}-test-build"
  description   = var.aws_codebuild_project_description
  build_timeout = var.build_timeout
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = var.aws_codebuild_environment_image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "${var.codepipeline_label}-test-log_group"
      stream_name = "${var.codepipeline_label}-test-log_stream"
    }

    # s3_logs {
    #   status   = "ENABLED"
    #   location = "${aws_s3_bucket.example.id}/build-log"
    # }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file("${path.module}/tpl/buildspec_lambda_test_command.yaml.tpl")
  }

  tags = merge(
    var.tags,
    {
      Description = "CodeBuild project designed to test lambdas before build docker images and push them into ECR"
    },
    {
      Parent = "CodePipeline label: ${var.codepipeline_label}"
    }
  )
}

resource "aws_codebuild_project" "lambda-build-project" {
  name          = "${var.codepipeline_label}-build-build"
  description   = var.aws_codebuild_project_description
  build_timeout = var.build_timeout
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = var.aws_codebuild_environment_image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "${var.codepipeline_label}-build-log_group"
      stream_name = "${var.codepipeline_label}-build-log_stream"
    }

    # s3_logs {
    #   status   = "ENABLED"
    #   location = "${aws_s3_bucket.example.id}/build-log"
    # }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file("${path.module}/tpl/buildspec_lambda_build_command.yaml.tpl")
  }

  tags = merge(
    var.tags,
    {
      Description = "CodeBuild project designed to build docker images and push them into ECR"
    },
    {
      Parent = "CodePipeline label: ${var.codepipeline_label}"
    }
  )
}

resource "aws_codebuild_project" "lambda-plan-project" {
  name          = "${var.codepipeline_label}-plan-build"
  description   = var.aws_codebuild_project_description
  build_timeout = var.build_timeout
  service_role  = aws_iam_role.tf_command_codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = var.aws_codebuild_environment_image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "${var.codepipeline_label}-plan-log_group"
      stream_name = "${var.codepipeline_label}-plan-log_stream"
    }

    # s3_logs {
    #   status   = "ENABLED"
    #   location = "${aws_s3_bucket.example.id}/build-log"
    # }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file("${path.module}/tpl/buildspec_lambda_plan_command.yaml.tpl")
  }

  tags = merge(
    var.tags,
    {
      Description = "CodeBuild project designed to prepare tf plan."
    },
    {
      Parent = "CodePipeline label: ${var.codepipeline_label}"
    }
  )
}

resource "aws_codebuild_project" "lambda-apply-project" {
  name          = "${var.codepipeline_label}-apply-build"
  description   = var.aws_codebuild_project_description
  build_timeout = var.build_timeout
  service_role  = aws_iam_role.tf_command_codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = var.aws_codebuild_environment_image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "${var.codepipeline_label}-apply-log_group"
      stream_name = "${var.codepipeline_label}-apply-log_stream"
    }

    # s3_logs {
    #   status   = "ENABLED"
    #   location = "${aws_s3_bucket.example.id}/build-log"
    # }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file("${path.module}/tpl/buildspec_lambda_apply_command.yaml.tpl")
  }

  tags = merge(
    var.tags,
    {
      Description = "CodeBuild project designed to validate plan and apply lambda tf layer"
    },
    {
      Parent = "CodePipeline label: ${var.codepipeline_label}"
    }
  )
}
