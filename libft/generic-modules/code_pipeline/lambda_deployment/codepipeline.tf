# S3 Secure Bucket
module "s3_bucket" {
  source = "../../../generic-modules/s3/secure_bucket"

  bucket = substr("${var.codepipeline_label}-artifacts-${random_string.random.result}", 0, 63)

  tags = merge(
    var.tags,
    {
      Description = "S3 bucker designed for codepipeline artifacts storing"
    },
    {
      Parent = "CodePipeline label: ${var.codepipeline_label}"
    }
  )

}

resource "aws_codepipeline" "default" {
  name     = var.codepipeline_label
  role_arn = join("", aws_iam_role.default.*.arn)

  tags = merge(
    var.tags,
    {
      Description = "CodePipeline designed for test/build/push/deploy lambda docker images"
    }
  )

  artifact_store {
    location = module.s3_bucket.s3_bucket_bucket
    type     = "S3"
  }

  depends_on = [
    aws_iam_role_policy_attachment.s3,
    aws_iam_role_policy_attachment.codebuild,
    aws_iam_role_policy_attachment.codestar,
    # aws_codebuild_project.project,
    # aws_codebuild_project.lambda-test-project,
    aws_codebuild_project.lambda-apply-project
  ]

  # Source
  stage {
    name = "Source"

    # Lambda source
    action {
      name             = "Lambda-code-source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["lambdacode"]

      configuration = {
        BranchName           = var.lambda_code_branch
        DetectChanges        = false
        ConnectionArn        = var.gh_connection_arn
        FullRepositoryId     = "${var.lambda_code_repo_owner}/${var.lambda_code_repo_name}"
        OutputArtifactFormat = "CODEBUILD_CLONE_REF"
      }
    }

    # TF source
    action {
      name             = "TF-code-source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["tfcode"]

      configuration = {
        DetectChanges        = false
        BranchName           = var.tf_code_branch
        ConnectionArn        = var.gh_connection_arn
        FullRepositoryId     = "${var.tf_code_repo_owner}/${var.tf_code_repo_name}"
        OutputArtifactFormat = "CODEBUILD_CLONE_REF"
      }
    }

  }

  stage {
    name = "Checkout"

    action {
      name      = "Lambda-checkout"
      namespace = "lambdaCheckout"
      version   = 1
      category  = "Build"
      provider  = "CodeBuild"
      owner     = "AWS"

      input_artifacts  = ["lambdacode"]
      output_artifacts = ["checked_out_lambda_code"]

      configuration = {
        ProjectName          = "${var.codepipeline_label}-checkout"
        EnvironmentVariables = "[{\"name\":\"VERSION\",\"value\":\"${var.lambda_version}\",\"type\":\"PLAINTEXT\"}]"
      }
    }

    action {
      name     = "Infrastructure-checkout"
      version  = 1
      category = "Build"
      provider = "CodeBuild"
      owner    = "AWS"

      input_artifacts  = ["tfcode"]
      output_artifacts = ["checked_out_terraform_code"]

      configuration = {
        ProjectName          = "${var.codepipeline_label}-checkout"
        EnvironmentVariables = "[{\"name\":\"VERSION\",\"value\":\"${var.infrastructure_version}\"}]"
      }
    }
  }

  # Test
  stage {
    name = "Test-lambdas"

    # Test-cognito_preauthorization_lambda
    action {
      name     = "Test-cognito_preauthorization_lambda"
      category = "Build"
      owner    = "AWS"
      provider = "CodeBuild"
      version  = "1"

      input_artifacts = ["checked_out_lambda_code"]

      configuration = {
        ProjectName          = "${var.codepipeline_label}-test-build"
        EnvironmentVariables = <<-EOT
          [
            {"name":"LAMBDA_PATH","value":"cognito-preauthorization/python/","type":"PLAINTEXT"}
          ]
        EOT
      }
    }

    # Test-cognito_presignup_lambda
    action {
      name     = "Test-cognito_presignup_lambda"
      category = "Build"
      owner    = "AWS"
      provider = "CodeBuild"
      version  = "1"

      input_artifacts = ["checked_out_lambda_code"]

      configuration = {
        ProjectName          = "${var.codepipeline_label}-test-build"
        EnvironmentVariables = <<-EOT
          [
            {"name":"LAMBDA_PATH","value":"cognito-presignup/python/","type":"PLAINTEXT"}
          ]
        EOT
      }
    }

    # Test-codepipeline_slack_integration_lambda
    action {
      name     = "Test-codepipeline_slack_integration_lambda"
      category = "Build"
      owner    = "AWS"
      provider = "CodeBuild"
      version  = "1"

      input_artifacts = ["checked_out_lambda_code"]

      configuration = {
        ProjectName          = "${var.codepipeline_label}-test-build"
        EnvironmentVariables = <<-EOT
          [
            {"name":"LAMBDA_PATH","value":"codepipeline-slack/python/","type":"PLAINTEXT"}
          ]
        EOT
      }
    }
    action {
      name     = "Test-cognito_post_confirmation_lambda"
      category = "Build"
      owner    = "AWS"
      provider = "CodeBuild"
      version  = "1"

      input_artifacts = ["checked_out_lambda_code"]

      configuration = {
        ProjectName          = "${var.codepipeline_label}-test-build"
        EnvironmentVariables = <<-EOT
          [
            {"name":"LAMBDA_PATH","value":"cognito-post-confirmation/python/","type":"PLAINTEXT"}
          ]
        EOT
      }
    }
  }

  # Build
  stage {
    name = "Build-lambdas"

    # Build-cognito_preauthorization_lambda
    action {
      name     = "Build-cognito_preauthorization_lambda"
      category = "Build"
      owner    = "AWS"
      provider = "CodeBuild"
      version  = "1"

      input_artifacts = ["checked_out_lambda_code"]

      configuration = {
        ProjectName          = "${var.codepipeline_label}-build-build"
        EnvironmentVariables = <<-EOT
          [
            {"name":"IMAGE_REPO_NAME","value":"${var.lambda_names["cognito_preauthorization_lambda"]}","type":"PLAINTEXT"},
            {"name":"AWS_ACCOUNT_ID","value":"${data.aws_caller_identity.current.account_id}","type":"PLAINTEXT"},
            {"name":"DOCKERFILE_NAME","value":"${var.dockerfile_name}","type":"PLAINTEXT"},
            {"name":"ECR_REGION","value":"${var.ecr_region}","type":"PLAINTEXT"},
            {"name":"ECR_ACCOUNT_ID","value":"${var.ecr_account_id}","type":"PLAINTEXT"},
            {"name":"LAMBDA_PATH","value":"cognito-preauthorization/python/","type":"PLAINTEXT"},
            {"name":"PRIVATE_CERT_BASE64","value":"/phoenix-app/${var.environment}/shared/ecs/phoenix_local/ca_b64","type":"PARAMETER_STORE"},
            {"name":"TAG","value":"#{lambdaCheckout.VERSION_NAME}","type":"PLAINTEXT"},
            {"name":"ENVIRONMENT","value":"${var.environment}","type":"PLAINTEXT"}
          ]
        EOT
      }
    }

    # Build-cognito_presignup_lambda
    action {
      name     = "Build-cognito_presignup_lambda"
      category = "Build"
      owner    = "AWS"
      provider = "CodeBuild"
      version  = "1"

      input_artifacts = ["checked_out_lambda_code"]

      configuration = {
        ProjectName          = "${var.codepipeline_label}-build-build"
        EnvironmentVariables = <<-EOT
          [
            {"name":"IMAGE_REPO_NAME","value":"${var.lambda_names["cognito_presignup_lambda"]}","type":"PLAINTEXT"},
            {"name":"AWS_ACCOUNT_ID","value":"${data.aws_caller_identity.current.account_id}","type":"PLAINTEXT"},
            {"name":"DOCKERFILE_NAME","value":"${var.dockerfile_name}","type":"PLAINTEXT"},
            {"name":"ECR_REGION","value":"${var.ecr_region}","type":"PLAINTEXT"},
            {"name":"ECR_ACCOUNT_ID","value":"${var.ecr_account_id}","type":"PLAINTEXT"},
            {"name":"LAMBDA_PATH","value":"cognito-presignup/python/","type":"PLAINTEXT"},
            {"name":"PRIVATE_CERT_BASE64","value":"/phoenix-app/${var.environment}/shared/ecs/phoenix_local/ca_b64","type":"PARAMETER_STORE"},
            {"name":"TAG","value":"#{lambdaCheckout.VERSION_NAME}","type":"PLAINTEXT"}
          ]
        EOT
      }
    }

    # Build-codepipeline_slack_integration_lambda
    action {
      name     = "Build-codepipeline_slack_integration_lambda"
      category = "Build"
      owner    = "AWS"
      provider = "CodeBuild"
      version  = "1"

      input_artifacts = ["checked_out_lambda_code"]

      configuration = {
        ProjectName          = "${var.codepipeline_label}-build-build"
        EnvironmentVariables = <<-EOT
          [
            {"name":"IMAGE_REPO_NAME","value":"${var.lambda_names["codepipeline_slack_integration_lambda"]}","type":"PLAINTEXT"},
            {"name":"AWS_ACCOUNT_ID","value":"${data.aws_caller_identity.current.account_id}","type":"PLAINTEXT"},
            {"name":"DOCKERFILE_NAME","value":"${var.dockerfile_name}","type":"PLAINTEXT"},
            {"name":"ECR_REGION","value":"${var.ecr_region}","type":"PLAINTEXT"},
            {"name":"ECR_ACCOUNT_ID","value":"${var.ecr_account_id}","type":"PLAINTEXT"},
            {"name":"LAMBDA_PATH","value":"codepipeline-slack/python/","type":"PLAINTEXT"},
            {"name":"PRIVATE_CERT_BASE64","value":"/phoenix-app/${var.environment}/shared/ecs/phoenix_local/ca_b64","type":"PARAMETER_STORE"},
            {"name":"TAG","value":"#{lambdaCheckout.VERSION_NAME}","type":"PLAINTEXT"}
          ]
        EOT
      }
    }
    action {
      name     = "Build-cognito_post_confirmation_lambda"
      category = "Build"
      owner    = "AWS"
      provider = "CodeBuild"
      version  = "1"

      input_artifacts = ["checked_out_lambda_code"]

      configuration = {
        ProjectName          = "${var.codepipeline_label}-build-build"
        EnvironmentVariables = <<-EOT
          [
            {"name":"IMAGE_REPO_NAME","value":"${var.lambda_names["cognito_post_confirmation_lambda"]}","type":"PLAINTEXT"},
            {"name":"AWS_ACCOUNT_ID","value":"${data.aws_caller_identity.current.account_id}","type":"PLAINTEXT"},
            {"name":"DOCKERFILE_NAME","value":"${var.dockerfile_name}","type":"PLAINTEXT"},
            {"name":"ECR_REGION","value":"${var.ecr_region}","type":"PLAINTEXT"},
            {"name":"ECR_ACCOUNT_ID","value":"${var.ecr_account_id}","type":"PLAINTEXT"},
            {"name":"LAMBDA_PATH","value":"cognito-post-confirmation/python/","type":"PLAINTEXT"},
            {"name":"PRIVATE_CERT_BASE64","value":"/phoenix-app/${var.environment}/shared/ecs/phoenix_local/ca_b64","type":"PARAMETER_STORE"},
            {"name":"TAG","value":"#{lambdaCheckout.VERSION_NAME}","type":"PLAINTEXT"}
          ]
        EOT
      }
    }
  }

  # Plan
  stage {
    name = "Plan"

    action {
      name     = "Plan"
      category = "Build"
      owner    = "AWS"
      provider = "CodeBuild"
      version  = "1"

      input_artifacts  = ["checked_out_terraform_code", "checked_out_lambda_code"]
      output_artifacts = ["tfplan"]

      configuration = {
        PrimarySource        = "checked_out_terraform_code"
        ProjectName          = "${var.codepipeline_label}-plan-build"
        EnvironmentVariables = <<-EOT
          [
            {"name":"LAMBDA_CODE_BRANCH","value":"${var.tf_code_branch}","type":"PLAINTEXT"},
            {"name":"LAMBDA_MODULE_PATH","value":"${var.lambda_module_path}","type":"PLAINTEXT"},
            {"name":"ENV","value":"${var.environment}","type":"PLAINTEXT"},
            {"name":"TAG","value":"#{lambdaCheckout.VERSION_NAME}","type":"PLAINTEXT"}
          ]
        EOT
      }
    }
  }

  # Apply
  stage {
    name = "Apply"

    action {
      name     = "Apply"
      category = "Build"
      owner    = "AWS"
      provider = "CodeBuild"
      version  = "1"

      input_artifacts = ["tfplan", "checked_out_terraform_code", "checked_out_lambda_code"]

      configuration = {
        PrimarySource        = "tfplan"
        ProjectName          = "${var.codepipeline_label}-apply-build"
        EnvironmentVariables = <<-EOT
          [
            {"name":"LAMBDA_VAR_service_version","value":"\"mock\"","type":"PLAINTEXT"},
            {"name":"LAMBDA_CODE_BRANCH","value":"${var.tf_code_branch}","type":"PLAINTEXT"},
            {"name":"LAMBDA_MODULE_PATH","value":"${var.lambda_module_path}","type":"PLAINTEXT"},
            {"name":"ENV","value":"${var.environment}","type":"PLAINTEXT"}
          ]
        EOT
      }
    }
  }

}
