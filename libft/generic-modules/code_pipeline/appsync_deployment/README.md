## Requirements

Prepared module for appsync deployment (50.appsync in case of phoenix-app)

## Note

Can't create appsync api from scratch in current implementation.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codebuild_project.checkout](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codebuild_project.tf-apply-project](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codebuild_project.tf-plan-project](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codepipeline.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) | resource |
| [aws_iam_role.codebuild_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.tf_command_codebuild_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_s3_bucket.artifact_store](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.https_only](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.public_access_block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_default_tags.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/default_tags) | data source |
| [aws_iam_policy_document.appsync_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_role_code_build](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_role_code_pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_role_tf_command_code_build](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloud_watch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloud_watch_for_tf_command_build](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.code_build_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.code_build_s3_tf_states](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codestar](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.dynamodb_tf_state_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.tf_bucket_replication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.waf](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_code_branch"></a> [app\_code\_branch](#input\_app\_code\_branch) | Branch of the GitHub repository with app code, _e.g._ `develop` | `string` | `"develop"` | no |
| <a name="input_app_code_repo_name"></a> [app\_code\_repo\_name](#input\_app\_code\_repo\_name) | GitHub repository name of the application to be built and deployed to ECS | `string` | n/a | yes |
| <a name="input_app_code_repo_owner"></a> [app\_code\_repo\_owner](#input\_app\_code\_repo\_owner) | GitHub Organization or Username | `string` | `"phoenix"` | no |
| <a name="input_appsync_admin_schema"></a> [appsync\_admin\_schema](#input\_appsync\_admin\_schema) | n/a | `any` | n/a | yes |
| <a name="input_appsync_be_schema"></a> [appsync\_be\_schema](#input\_appsync\_be\_schema) | n/a | `any` | n/a | yes |
| <a name="input_appsync_module_path"></a> [appsync\_module\_path](#input\_appsync\_module\_path) | Path of the appsync deployment TF module | `string` | n/a | yes |
| <a name="input_aws_backend_region"></a> [aws\_backend\_region](#input\_aws\_backend\_region) | Terraform AWS backend region | `string` | `"us-east-1"` | no |
| <a name="input_aws_codebuild_environment_image"></a> [aws\_codebuild\_environment\_image](#input\_aws\_codebuild\_environment\_image) | AWS CodeBuild environment image | `string` | `"aws/codebuild/amazonlinux2-x86_64-standard:3.0"` | no |
| <a name="input_aws_codebuild_project_description"></a> [aws\_codebuild\_project\_description](#input\_aws\_codebuild\_project\_description) | AWS CodeBuild project description | `string` | n/a | yes |
| <a name="input_codepipeline_label"></a> [codepipeline\_label](#input\_codepipeline\_label) | Codepipeline label | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | what environment we deploy service into | `any` | n/a | yes |
| <a name="input_gh_connection_arn"></a> [gh\_connection\_arn](#input\_gh\_connection\_arn) | AWS Github connection ARN (you should create it manually) | `string` | n/a | yes |
| <a name="input_infrastructure_version"></a> [infrastructure\_version](#input\_infrastructure\_version) | Version tag to build from | `string` | `"HEAD"` | no |
| <a name="input_poll_source_changes"></a> [poll\_source\_changes](#input\_poll\_source\_changes) | Periodically check the location of your source content and run the pipeline if changes are detected | `bool` | `true` | no |
| <a name="input_product_name"></a> [product\_name](#input\_product\_name) | Product name | `string` | n/a | yes |
| <a name="input_service_version"></a> [service\_version](#input\_service\_version) | Version tag to build from | `string` | `"HEAD"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Resource tags | `map(any)` | n/a | yes |
| <a name="input_tf_code_branch"></a> [tf\_code\_branch](#input\_tf\_code\_branch) | Branch of the GitHub repository tf code, _e.g._ `develop` | `string` | `"develop"` | no |
| <a name="input_tf_code_repo_name"></a> [tf\_code\_repo\_name](#input\_tf\_code\_repo\_name) | GitHub repository name of the application to be built and deployed to ECS | `string` | n/a | yes |
| <a name="input_tf_code_repo_owner"></a> [tf\_code\_repo\_owner](#input\_tf\_code\_repo\_owner) | GitHub Organization or Username | `string` | `"phoenix"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_codepipelines"></a> [codepipelines](#output\_codepipelines) | n/a |

## Usage

```hcl
module "appsync_deploy_pipeline" {
  source = "../../../generic-modules/code_pipeline/appsync_deployment"

  gh_connection_arn                 = var.gh_connection_arn
  aws_codebuild_project_description = "Designed for initial and continious deployment of appsync and schemaa"
  codepipeline_label                = "${var.tag_product}-${var.environment}-code-pipeline-appsync-deployment"
  app_code_repo_name                = var.app_code_repo_name
  app_code_repo_owner               = var.app_code_repo_owner
  app_code_branch                   = var.app_code_branch
  tf_code_repo_owner                = var.tf_code_repo_owner
  tf_code_repo_name                 = var.tf_code_repo_name
  tf_code_branch                    = var.tf_code_branch
  appsync_module_path               = var.appsync_module_path
  appsync_be_schema                 = "/home/ec2-user/environment/phoenix-be/deploy/be/appsync/schema/schema.graphql"
  appsync_admin_schema              = "/home/ec2-user/environment/phoenix-be/deploy/admin/appsync/schema/schema.graphql"
  aws_backend_region                = var.aws_backend_region
  product_name                      = var.tag_product
  environment                       = var.environment

  tags = {
    Orchestration = "https://github.com/phoenix/phoenix-infrastructure/blob/develop/deployments/phoenix-app-modularized/51.appsync_pipeline"
    Jira          = "https://phoenix.atlassian.net/browse/TECHGEN-3927"
  }

  service_version        = var.service_version
  infrastructure_version = var.infrastructure_version
}
```