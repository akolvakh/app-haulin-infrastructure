## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.13.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.3 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_framework_module_ver"></a> [framework\_module\_ver](#module\_framework\_module\_ver) | ../../../../libft/generic-modules/framework/module_ver | n/a |
| <a name="module_label"></a> [label](#module\_label) | ../../../../libft/generic-modules/null_label | n/a |
| <a name="module_shared_accounts_config"></a> [shared\_accounts\_config](#module\_shared\_accounts\_config) | ../../../../libft/generic-modules/shared_config/accounts | n/a |
| <a name="module_shared_ecs_services_config"></a> [shared\_ecs\_services\_config](#module\_shared\_ecs\_services\_config) | ../../../../libft/generic-modules/shared_config/ecs_services | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ecr_repository.ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecs_cluster.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_iam_policy.task_execution_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.task_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.task_execution_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.task_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [random_id.exec_uniq](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_id.task_uniq](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_default_tags.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/default_tags) | data source |
| [terraform_remote_state.acm_private_certificate](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.alb](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.bastion](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.cache](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.cloud9](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.cognito](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.db](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.dns](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.gitlab](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.kafka](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.lambda_cognito_post_auth](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.lambda_cognito_post_confirmation_admin](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.parameters](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.route53](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.secrets](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.service_discovery](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.ses](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.sg](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.sns](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.static_ips](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.vpc](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.workmail](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | -------------------------------------------------------------- General -------------------------------------------------------------- | `any` | n/a | yes |
| <a name="input_cluster_default_capacity_provider"></a> [cluster\_default\_capacity\_provider](#input\_cluster\_default\_capacity\_provider) | ecs cluster default capacity provider, FARGATE\|FARGATE\_SPOT | `string` | `"FARGATE"` | no |
| <a name="input_contact"></a> [contact](#input\_contact) | n/a | `any` | n/a | yes |
| <a name="input_docker_registry_url"></a> [docker\_registry\_url](#input\_docker\_registry\_url) | url of ECR repo | `string` | `"528677244674.dkr.ecr.us-east-1.amazonaws.com"` | no |
| <a name="input_ecs_desired_task_count"></a> [ecs\_desired\_task\_count](#input\_ecs\_desired\_task\_count) | n/a | `number` | `2` | no |
| <a name="input_ecs_service_name_2_ecr_url_map"></a> [ecs\_service\_name\_2\_ecr\_url\_map](#input\_ecs\_service\_name\_2\_ecr\_url\_map) | map of service names to docker repos to grab images from. To be set by CI/CD | `map(string)` | `{}` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `any` | n/a | yes |
| <a name="input_product"></a> [product](#input\_product) | n/a | `any` | n/a | yes |
| <a name="input_tag_orchestration"></a> [tag\_orchestration](#input\_tag\_orchestration) | n/a | `any` | n/a | yes |
| <a name="input_tf_framework_component_version"></a> [tf\_framework\_component\_version](#input\_tf\_framework\_component\_version) | GIT tag or branch if no tag vailable, identifying terraform source code version being run. Set by Makefile Framework | `any` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_ecr_urls"></a> [ecs\_ecr\_urls](#output\_ecs\_ecr\_urls) | n/a |
| <a name="output_ecs_main_cluster_arn"></a> [ecs\_main\_cluster\_arn](#output\_ecs\_main\_cluster\_arn) | arn of ECS cluster |
| <a name="output_ecs_main_cluster_name"></a> [ecs\_main\_cluster\_name](#output\_ecs\_main\_cluster\_name) | name of ECS cluster |
| <a name="output_ecs_service_name_2_ecr_url_map"></a> [ecs\_service\_name\_2\_ecr\_url\_map](#output\_ecs\_service\_name\_2\_ecr\_url\_map) | map of ecs serviceName to ECR repo URL per service. Sample {'be' = '177795352040.dkr.ecr.us-west-1.amazonaws.com/service\_be'} |
| <a name="output_ecs_service_name_2_task_execution_role_map"></a> [ecs\_service\_name\_2\_task\_execution\_role\_map](#output\_ecs\_service\_name\_2\_task\_execution\_role\_map) | map of serviceName to arn of taskExecutionRole per service. Sample {'be' = 'arn:.../executionRole'} |
| <a name="output_ecs_service_name_2_task_role_map"></a> [ecs\_service\_name\_2\_task\_role\_map](#output\_ecs\_service\_name\_2\_task\_role\_map) | map of serviceName to arn of taskExecutionRole per service. Sample {'be' = 'arn:.../executionRole'} |
| <a name="output_ecs_service_name_2_task_role_name_map"></a> [ecs\_service\_name\_2\_task\_role\_name\_map](#output\_ecs\_service\_name\_2\_task\_role\_name\_map) | map of serviceName to arn of taskExecutionRole per service. Sample {'be' = 'arn:.../executionRole'} |
