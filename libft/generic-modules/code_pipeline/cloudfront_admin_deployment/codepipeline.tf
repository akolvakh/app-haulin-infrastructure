# S3 Secure Bucket
module "s3_bucket" {
  source = "../../../generic-modules/s3/secure_bucket"

  bucket = "${var.codepipeline_label}-artifacts-${random_string.random.result}"

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
      Description = "CodePipeline designed to build Admin portal frontend"
    }
  )

  artifact_store {
    location = module.s3_bucket.s3_bucket_bucket
    type     = "S3"
  }

  depends_on = [
    aws_iam_role_policy_attachment.s3,
    aws_iam_role_policy_attachment.codebuild,
    aws_iam_role_policy_attachment.codestar
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

      configuration = {
        BranchName           = var.app_code_branch
        ConnectionArn        = var.gh_connection_arn
        FullRepositoryId     = "${var.app_code_repo_owner}/${var.app_code_repo_name}"
        OutputArtifactFormat = "CODEBUILD_CLONE_REF"
        DetectChanges        = local.common.Environment == "dev"
      }
    }
  }

  stage {
    name = "Checkout"

    action {
      name      = "Build"
      namespace = "checkout"
      category  = "Build"
      owner     = "AWS"
      provider  = "CodeBuild"
      version   = "1"

      input_artifacts  = ["code"]
      output_artifacts = ["checked_out_code"]

      configuration = {
        ProjectName = local.codebuild_project_name
        EnvironmentVariables = jsonencode([{
          name  = "VERSION"
          value = var.admin_version
          type  = "PLAINTEXT"
        }])
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

      input_artifacts = ["checked_out_code"]

      configuration = {
        ProjectName = var.codebuild_project_name
        EnvironmentVariables = jsonencode([{
          name  = "VERSION"
          value = "#{checkout.VERSION_NAME}"
          type  = "PLAINTEXT"
        }])
      }
    }
  }
}
