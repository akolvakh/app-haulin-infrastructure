resource "aws_s3_bucket" "artifact_store" {
  bucket        = "${var.codepipeline_label}-artifacts"
  acl           = "private"
  force_destroy = true

  tags = merge(
    var.tags,
    {
      Description = "S3 bucker designed for codepipeline artifacts storing"
    },
    {
      Parent = "CodePipeline label: ${var.codepipeline_label}"
    }
  )

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.artifact_store.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "https_only" {
  bucket = aws_s3_bucket.artifact_store.id
  // ecnrypt everything
  // IP whitelist S3 when possible. Local VPC only
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "SecPolicy"
    Statement = [
      {
        Sid       = "HTTPSOnly"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.artifact_store.arn,
          "${aws_s3_bucket.artifact_store.arn}/*",
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      },
    ]
  })
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
    location = join("", aws_s3_bucket.artifact_store.*.bucket)
    type     = "S3"
  }

  depends_on = [
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
      name     = "Service-checkout"
      version  = 1
      category = "Build"
      provider = "CodeBuild"
      owner    = "AWS"


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
            {"name":"TERRAFORM_MODULE_PATH","value":"${var.appsync_module_path}","type":"PLAINTEXT"},
            {"name":"APPSYNC_BE_SCHEMA","value":"${var.appsync_be_schema}","type":"PLAINTEXT"},
            {"name":"APPSYNC_ADMIN_SCHEMA","value":"${var.appsync_admin_schema}","type":"PLAINTEXT"},
            {"name":"BE_RESOLVERS_DIR","value":"${var.be_resolvers_dir}","type":"PLAINTEXT"},
            {"name":"CONFIG_RESOLVERS_DIR","value":"${var.config_resolvers_dir}","type":"PLAINTEXT"},
            {"name":"ADMIN_RESOLVERS_DIR","value":"${var.admin_resolvers_dir}","type":"PLAINTEXT"},
            {"name":"I2C_RESOLVERS_DIR","value":"${var.i2c_resolvers_dir}","type":"PLAINTEXT"},
            {"name":"NOTIFICATION_RESOLVERS_DIR","value":"${var.notification_resolvers_dir}","type":"PLAINTEXT"},
            {"name":"ENV","value":"${var.environment}","type":"PLAINTEXT"}
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

      input_artifacts = ["tfplan", "checked_out_terraform_code", "checked_out_code"]

      configuration = {
        PrimarySource        = "tfplan"
        ProjectName          = "${var.codepipeline_label}-tf-apply-build"
        EnvironmentVariables = <<-EOT
          [
            {"name":"TERRAFORM_MODULE_PATH","value":"${var.appsync_module_path}","type":"PLAINTEXT"},
            {"name":"ENV","value":"${var.environment}","type":"PLAINTEXT"}
          ]
        EOT
      }
    }
  }
}
