## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.0.1 |

Prepared module for ecs service deployment that will be invoked during code pipeline runtime.

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
| [aws_codebuild_project.project](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codebuild_project.tf-apply-project](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codebuild_project.tf-plan-project](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codepipeline.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) | resource |
| [aws_iam_policy.cloud_watch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cloud_watch_for_tf_command_build](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.code_build_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.code_build_s3_tf_states](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.codestar](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.dynamodb_tf_state_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ecr_auth](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ecs_service_deploy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.iam_pass_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.tf_bucket_replication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.codebuild_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.tf_command_codebuild_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.cloud_watch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cloud_watch_for_tf_command_build](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.code_build_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.code_build_s3_tf_states](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.codestar](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.codestar_for_tf_command_build](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.dynamodb_tf_state_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ec2_ro](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecr_auth](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_service_deploy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.iam_pass_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.s3_tf_for_tf_command_build](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.tf_bucket_replication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_s3_bucket.artifact_store](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
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
| [aws_iam_policy_document.ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecr_auth](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecs_service_deploy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.iam_pass_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.tf_bucket_replication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_code_branch"></a> [app\_code\_branch](#input\_app\_code\_branch) | Branch of the GitHub repository with app code, _e.g._ `develop` | `string` | `"develop"` | no |
| <a name="input_app_code_repo_name"></a> [app\_code\_repo\_name](#input\_app\_code\_repo\_name) | GitHub repository name of the application to be built and deployed to ECS | `string` | n/a | yes |
| <a name="input_app_code_repo_owner"></a> [app\_code\_repo\_owner](#input\_app\_code\_repo\_owner) | GitHub Organization or Username | `string` | `"phoenix"` | no |
| <a name="input_aws_backend_region"></a> [aws\_backend\_region](#input\_aws\_backend\_region) | Terraform AWS backend region | `string` | `"us-east-2"` | no |
| <a name="input_aws_codebuild_environment_image"></a> [aws\_codebuild\_environment\_image](#input\_aws\_codebuild\_environment\_image) | AWS CodeBuild environment image | `string` | `"aws/codebuild/amazonlinux2-x86_64-standard:3.0"` | no |
| <a name="input_aws_codebuild_project_description"></a> [aws\_codebuild\_project\_description](#input\_aws\_codebuild\_project\_description) | AWS CodeBuild project description | `string` | n/a | yes |
| <a name="input_buildspec_filename"></a> [buildspec\_filename](#input\_buildspec\_filename) | buildspec file name | `string` | `"buildspec.yaml"` | no |
| <a name="input_codepipeline_label"></a> [codepipeline\_label](#input\_codepipeline\_label) | Codepipeline label | `string` | n/a | yes |
| <a name="input_dockerfile_name"></a> [dockerfile\_name](#input\_dockerfile\_name) | Dockerfile name | `string` | `"Dockerfile"` | no |
| <a name="input_ecr_account_id"></a> [ecr\_account\_id](#input\_ecr\_account\_id) | n/a | `string` | `"822856406661"` | no |
| <a name="input_ecr_region"></a> [ecr\_region](#input\_ecr\_region) | n/a | `string` | `"us-east-1"` | no |
| <a name="input_ecs_cluster_name"></a> [ecs\_cluster\_name](#input\_ecs\_cluster\_name) | ECS Cluster Name | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | what environment we deploy service into | `any` | n/a | yes |
| <a name="input_gh_connection_arn"></a> [gh\_connection\_arn](#input\_gh\_connection\_arn) | AWS Github connection ARN (you should create it manually) | `string` | n/a | yes |
| <a name="input_poll_source_changes"></a> [poll\_source\_changes](#input\_poll\_source\_changes) | Periodically check the location of your source content and run the pipeline if changes are detected | `bool` | `true` | no |
| <a name="input_product_name"></a> [product\_name](#input\_product\_name) | Product name | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | ECS Service Name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Resource tags | `map(any)` | n/a | yes |
| <a name="input_task_execution_role_arn"></a> [task\_execution\_role\_arn](#input\_task\_execution\_role\_arn) | The ARN of ECS task execution role | `string` | n/a | yes |
| <a name="input_task_role_arn"></a> [task\_role\_arn](#input\_task\_role\_arn) | The ARN of ECS task role | `string` | n/a | yes |
| <a name="input_tf_code_branch"></a> [tf\_code\_branch](#input\_tf\_code\_branch) | Branch of the GitHub repository tf code, _e.g._ `develop` | `string` | `"develop"` | no |
| <a name="input_tf_code_repo_name"></a> [tf\_code\_repo\_name](#input\_tf\_code\_repo\_name) | GitHub repository name of the application to be built and deployed to ECS | `string` | n/a | yes |
| <a name="input_tf_code_repo_owner"></a> [tf\_code\_repo\_owner](#input\_tf\_code\_repo\_owner) | GitHub Organization or Username | `string` | `"phoenix"` | no |
| <a name="input_tf_ecs_module_path"></a> [tf\_ecs\_module\_path](#input\_tf\_ecs\_module\_path) | Path of the ECS service deployment TF module | `string` | n/a | yes |

## Outputs

No outputs.

## Example

```
module "be_deploy_pipeline" {
  source = "../../../generic-modules/code_pipeline/ecs_build_and_deploy"

  gh_connection_arn                 = var.gh_connection_arn
  aws_codebuild_project_description = "Designed for initial and continious deployment of ${var.tag_product}-${var.environment}-ecs-service-${var.service_name}"
  # aws_ecr_repo_name                 = var.aws_ecr_repo_name
  codepipeline_label  = "${var.tag_product}-${var.environment}-code-pipeline-${var.service_name}"
  app_code_repo_name  = var.app_code_repo_name
  app_code_repo_owner = var.app_code_repo_owner
  app_code_branch     = var.app_code_branch
  tf_code_repo_owner  = var.tf_code_repo_owner
  tf_code_repo_name   = var.tf_code_repo_name
  tf_code_branch      = var.tf_code_branch
  tf_ecs_module_path  = var.tf_ecs_module_path
  ecs_cluster_name    = data.terraform_remote_state.ecs.outputs.ecs_main_cluster_name
  product_name        = var.tag_product
  service_name        = var.service_name
  environment         = var.environment


  dockerfile_name         = "be.Dockerfile_ECR"
  task_execution_role_arn = data.terraform_remote_state.ecs.outputs.ecs_service_name_2_task_execution_role_map[var.service_name]
  task_role_arn           = data.terraform_remote_state.ecs.outputs.ecs_service_name_2_task_role_map[var.service_name]
  tags = {
    Orchestration = "https://github.com/phoenix/phoenix-infrastructure/blob/develop/deployments/phoenix-app-modularized/1001.codepipeline_ecs_deployment"
    Jira          = "https://phoenix.atlassian.net/browse/TECHGEN-2847"
    Product       = "${var.tag_product}"
    Environment   = "${var.environment}"
  }
}
```
