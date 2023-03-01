resource "aws_codebuild_project" "checkout" {
  name          = "${local.name_prefix}-checkout"
  build_timeout = "5"
  service_role  = aws_iam_role.db_deploy_codebuild_role.arn

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
      group_name  = "${local.name_prefix}-checkout-log_group"
      stream_name = "${local.name_prefix}-checkout-log_stream"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file("${path.module}/tpl/buildspec_checkout.yaml.tpl")
  }

  tags = {
    Description = "CodeBuild project designed to checking out code version"
  }
}

resource "aws_codebuild_project" "db_deploy" {
  name          = "${local.name_prefix}-default-deployDB"
  description   = "run DB data migration scripting"
  build_timeout = "5"
  service_role  = aws_iam_role.db_deploy_codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = var.aws_codebuild_environment_image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name  = "ENV_TYPE"
      value = local.common.Environment
    }

    environment_variable {
      name  = "ZPRODUCT"
      value = local.common.Product
    }

    environment_variable {
      name  = "DB_ENTRYPOINT"
      value = var.db_entrypoint
    }

    environment_variable {
      name  = "DB_PWD"
      value = "${var.db_pswd_secret_arn}:API_SECRET:"
      type  = "SECRETS_MANAGER"
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "${local.name_prefix}-default-deploy-log_group"
      stream_name = "${local.name_prefix}-default-deploy-log_stream"
    }
  }

  vpc_config {
    vpc_id             = var.vpc_id
    subnets            = var.db_subnet_ids
    security_group_ids = var.security_group_ids
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file("${path.module}/tpl/db.default.deploy.yaml.tpl")
  }
}
