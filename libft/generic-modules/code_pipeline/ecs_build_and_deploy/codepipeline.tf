# S3 Secure Bucket
module "s3_bucket" {
  source = "../../../../libft/generic-modules/s3-secure_bucket"

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
      Description = "CodePipeline designed for build/push/deploy docker images"
    }
  )

  artifact_store {
    location = module.s3_bucket.s3_bucket_bucket
    type     = "S3"
  }

  depends_on = [
    aws_iam_role_policy_attachment.s3,
    aws_iam_role_policy_attachment.codebuild,
    # aws_iam_role_policy_attachment.ecs,
    aws_iam_role_policy_attachment.codestar,
    aws_codebuild_project.project,
    aws_codebuild_project.tf-plan-project,
    aws_codebuild_project.tf-apply-project
  ]

  stage {
    name = "Source"

    action {
      name             = "APP-code-source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["code"]
      //DO WE USE THIS MODULE? build and deploy should seprate steps
      configuration = {
        BranchName           = var.app_code_branch
        ConnectionArn        = var.gh_connection_arn
        FullRepositoryId     = "${var.app_code_repo_owner}/${var.app_code_repo_name}"
        OutputArtifactFormat = "CODEBUILD_CLONE_REF"
        DetectChanges        = false
      }
    }
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
      name      = "Service-checkout"
      namespace = "serviceCheckout"
      version   = 1
      category  = "Build"
      provider  = "CodeBuild"
      owner     = "AWS"


      input_artifacts  = ["code"]
      output_artifacts = ["checked_out_code"]

      configuration = {
        ProjectName          = "${var.codepipeline_label}-checkout"
        EnvironmentVariables = "[{\"name\":\"VERSION\",\"value\":\"${var.service_version}\",\"type\":\"PLAINTEXT\"}]"
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

  stage {
    name = "Build"

    action {
      name     = "Build"
      category = "Build"
      owner    = "AWS"
      provider = "CodeBuild"
      version  = "1"

      input_artifacts  = ["checked_out_code"]
      output_artifacts = ["task"]

      configuration = {
        ProjectName          = "${var.codepipeline_label}-build"
        EnvironmentVariables = <<-EOT
          [
            {"name":"AWS_ACCOUNT_ID","value":"${data.aws_caller_identity.current.account_id}","type":"PLAINTEXT"},
            {"name":"IMAGE_REPO_NAME","value":"${var.product_name}_${var.service_name}","type":"PLAINTEXT"},
            {"name":"SERVICE_NAME","value":"${var.service_name}","type":"PLAINTEXT"},
            {"name":"DOCKERFILE_NAME","value":"${var.dockerfile_name}","type":"PLAINTEXT"},
            {"name":"ECR_REGION","value":"${var.ecr_region}","type":"PLAINTEXT"},
            {"name":"ECR_ACCOUNT_ID","value":"${var.ecr_account_id}","type":"PLAINTEXT"},
            {"name":"VERSION","value":"#{serviceCheckout.VERSION_NAME}","type":"PLAINTEXT"}
          ]
        EOT
      }
    }
  }

  stage {
    name = "TF_Plan"

    action {
      name     = "TF_Plan"
      category = "Build"
      owner    = "AWS"
      provider = "CodeBuild"
      version  = "1"

      input_artifacts  = ["checked_out_terraform_code", "checked_out_code"]
      output_artifacts = ["tfplan"]

      configuration = {
        PrimarySource        = "checked_out_code"
        ProjectName          = "${var.codepipeline_label}-tf-plan-build"
        EnvironmentVariables = <<-EOT
          [
            {"name":"TF_VAR_service_name","value":"\"${var.service_name}\"","type":"PLAINTEXT"},
            {"name":"TERRAFORM_COMMAND","value":"output","type":"PLAINTEXT"},
            {"name":"TF_CODE_BRANCH","value":"${var.tf_code_branch}","type":"PLAINTEXT"},
            {"name":"TERRAFORM_MODULE_PATH","value":"${var.tf_ecs_module_path}","type":"PLAINTEXT"},
            {"name":"ECS_ENV","value":"${var.environment}","type":"PLAINTEXT"},
            {"name":"VERSION","value":"#{serviceCheckout.VERSION_NAME}","type":"PLAINTEXT"}
          ]
        EOT
      }
    }
  }

  stage {
    name = "TF_Apply"

    action {
      name     = "TF_Apply"
      category = "Build"
      owner    = "AWS"
      provider = "CodeBuild"
      version  = "1"

      input_artifacts = ["tfplan", "checked_out_terraform_code"]

      configuration = {
        PrimarySource        = "checked_out_terraform_code"
        ProjectName          = "${var.codepipeline_label}-tf-apply-build"
        EnvironmentVariables = <<-EOT
          [
            {"name":"TF_VAR_service_version","value":"\"mock\"","type":"PLAINTEXT"},
            {"name":"TF_VAR_service_name","value":"\"${var.service_name}\"","type":"PLAINTEXT"},
            {"name":"TF_CODE_BRANCH","value":"${var.tf_code_branch}","type":"PLAINTEXT"},
            {"name":"TERRAFORM_MODULE_PATH","value":"${var.tf_ecs_module_path}","type":"PLAINTEXT"},
            {"name":"ECS_ENV","value":"${var.environment}","type":"PLAINTEXT"}
          ]
        EOT
      }
    }
  }

}
