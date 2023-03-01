resource "aws_codepipeline" "codepipeline" {
  name     = substr("${local.name_prefix}_default_${random_id.db.dec}", 0, 100)
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = module.codepipeline_bucket.s3_bucket_bucket
    type     = "S3"

  }
  // encrypted by default by AWs managed key

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn        = var.gh_connection_arn
        FullRepositoryId     = "${var.app_code_repo_owner}/${var.app_code_repo_name}"
        BranchName           = var.app_code_branch
        DetectChanges        = local.common.Environment == "dev"
        OutputArtifactFormat = "CODEBUILD_CLONE_REF"
      }
    }
  }

  stage {
    name = "Checkout"

    action {
      name     = "Migration-checkout"
      version  = 1
      category = "Build"
      provider = "CodeBuild"
      owner    = "AWS"

      input_artifacts  = ["source_output"]
      output_artifacts = ["checked_out_source"]

      configuration = {
        ProjectName          = "${local.name_prefix}-checkout"
        EnvironmentVariables = "[{\"name\":\"VERSION\",\"value\":\"${var.migrations_version}\",\"type\":\"PLAINTEXT\"}]"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name             = "deploy"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["checked_out_source"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName          = "${local.name_prefix}-default-deployDB"
        EnvironmentVariables = "[{\"name\":\"ENV_TYPE\",\"value\":\"${local.common.Environment}\",\"type\":\"PLAINTEXT\"}]"
      }
    }
  }

}
