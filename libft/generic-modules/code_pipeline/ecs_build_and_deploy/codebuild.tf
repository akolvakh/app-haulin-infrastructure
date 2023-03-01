# resource "aws_s3_bucket" "bucket" {
#   bucket = "name"
#   acl    = "private"
# }

resource "aws_codebuild_project" "checkout" {
  name          = "${var.codepipeline_label}-checkout"
  build_timeout = "5"
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

resource "aws_codebuild_project" "project" {
  name = "${var.codepipeline_label}-build"
  # description   = var.aws_codebuild_project_description
  build_timeout = "5"
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
    buildspec = file("${path.module}/tpl/buildspec_build.yaml.tpl")
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

resource "aws_codebuild_project" "tf-plan-project" {
  name = "${var.codepipeline_label}-tf-plan-build"
  # description   = var.aws_codebuild_project_description
  build_timeout = "5"
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
      group_name  = "${var.codepipeline_label}-tf-command-build-log_group"
      stream_name = "${var.codepipeline_label}-tf-command-build-log_stream"
    }

    # s3_logs {
    #   status   = "ENABLED"
    #   location = "${aws_s3_bucket.example.id}/build-log"
    # }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file("${path.module}/tpl/buildspec_tf_plan_command.yaml.tpl")
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

resource "aws_codebuild_project" "tf-apply-project" {
  name = "${var.codepipeline_label}-tf-apply-build"
  # description   = var.aws_codebuild_project_description
  build_timeout = "10"
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
      group_name  = "${var.codepipeline_label}-tf-command-build-log_group"
      stream_name = "${var.codepipeline_label}-tf-command-build-log_stream"
    }

    # s3_logs {
    #   status   = "ENABLED"
    #   location = "${aws_s3_bucket.example.id}/build-log"
    # }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file("${path.module}/tpl/buildspec_tf_apply_command.yaml.tpl")
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
