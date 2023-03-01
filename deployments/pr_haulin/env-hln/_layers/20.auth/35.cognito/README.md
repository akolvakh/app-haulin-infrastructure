## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.17.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.2.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cognito_app_ses"></a> [cognito\_app\_ses](#module\_cognito\_app\_ses) | ../../../../libft/generic-modules/ses | n/a |
| <a name="module_cognito_app_user_pool"></a> [cognito\_app\_user\_pool](#module\_cognito\_app\_user\_pool) | ../../../../libft/generic-modules/cognito/cognito2 | n/a |
| <a name="module_framework_module_ver"></a> [framework\_module\_ver](#module\_framework\_module\_ver) | ../../../../libft/generic-modules/framework/module_ver | n/a |
| <a name="module_label"></a> [label](#module\_label) | ../../../../libft/generic-modules/null_label | n/a |
| <a name="module_shared_external_dns"></a> [shared\_external\_dns](#module\_shared\_external\_dns) | ../../../../libft/generic-modules/shared_config_us_secondary/external_dns/ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cognito_identity_pool.admin_identity_pool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_identity_pool) | resource |
| [aws_cognito_identity_pool_roles_attachment.admin_identity_pool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_identity_pool_roles_attachment) | resource |
| [aws_iam_policy.cognito_admin_auth_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cognito_admin_unauth_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cognito_send_sms_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.sns_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.cognito_admin_auth_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.cognito_admin_unauth_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.cognito_send_sms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.sns_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.cognito_admin_auth_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cognito_admin_unauth_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cognito_send_sms_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.sns_log_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_permission.cognito_post_confirmation_admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_lambda_permission.cognito_postauthentification](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_ses_identity_policy.cognito_ses](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_identity_policy) | resource |
| [aws_sns_sms_preferences.sms_prefs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_sms_preferences) | resource |
| [aws_wafv2_web_acl.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl) | resource |
| [random_id.cognito_ex_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_id.ses_pol_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_id.ses_role_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_id.sns_pol_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_id.sns_role_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_default_tags.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/default_tags) | data source |
| [aws_iam_policy_document.cognito_admin_auth_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cognito_admin_auth_trust](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cognito_admin_unauth_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cognito_admin_unauth_trust](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cognito_ses](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cognito_sms_send](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cognito_sms_send_polcy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sns_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sns_role_assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [terraform_remote_state.acm_private_certificate](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.alb](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.bastion](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.cache](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.cloud9](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.db](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.dns](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.gitlab](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.kafka](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.lambda_cognito_post_auth](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.lambda_cognito_post_confirmation_admin](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.parameters](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.route53](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.s3](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
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
| <a name="input_cognito_additional_tags"></a> [cognito\_additional\_tags](#input\_cognito\_additional\_tags) | map of tags to be added to all resources created by this module | `map(string)` | `{}` | no |
| <a name="input_contact"></a> [contact](#input\_contact) | n/a | `any` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `any` | n/a | yes |
| <a name="input_external_dns_domain"></a> [external\_dns\_domain](#input\_external\_dns\_domain) | visible in internet DNS name of current environment. non-prod-PRODUCT.com/PRODUCT.com | `any` | n/a | yes |
| <a name="input_lambda_pre_signup_version"></a> [lambda\_pre\_signup\_version](#input\_lambda\_pre\_signup\_version) | version of pre signup lambda to deploy. To be set by CD autamation | `string` | `"latest"` | no |
| <a name="input_product"></a> [product](#input\_product) | n/a | `any` | n/a | yes |
| <a name="input_ses_aws_region"></a> [ses\_aws\_region](#input\_ses\_aws\_region) | -------------------------------------------------------------- SES -------------------------------------------------------------- | `any` | n/a | yes |
| <a name="input_sns_monthly_spend_limit"></a> [sns\_monthly\_spend\_limit](#input\_sns\_monthly\_spend\_limit) | aws budget cap for SNS sending in this account, in $. Ref https://docs.aws.amazon.com/sns/latest/dg/sms_preferences.html | `number` | n/a | yes |
| <a name="input_tag_orchestration"></a> [tag\_orchestration](#input\_tag\_orchestration) | n/a | `any` | n/a | yes |
| <a name="input_tf_framework_component_version"></a> [tf\_framework\_component\_version](#input\_tf\_framework\_component\_version) | GIT tag or branch if no tag vailable, identifying terraform source code version being run. Set by Makefile Framework | `any` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cognito_app_client_id"></a> [cognito\_app\_client\_id](#output\_cognito\_app\_client\_id) | Cognito main app client ID |
| <a name="output_cognito_app_pool_arn"></a> [cognito\_app\_pool\_arn](#output\_cognito\_app\_pool\_arn) | ARN of cognito user pool |
| <a name="output_cognito_app_pool_domain_prefix"></a> [cognito\_app\_pool\_domain\_prefix](#output\_cognito\_app\_pool\_domain\_prefix) | Domain of cognito user pool |
| <a name="output_cognito_app_pool_endpoint"></a> [cognito\_app\_pool\_endpoint](#output\_cognito\_app\_pool\_endpoint) | Endpoint  of cognito user pool |
| <a name="output_cognito_app_pool_id"></a> [cognito\_app\_pool\_id](#output\_cognito\_app\_pool\_id) | ID of cognito user pool |
