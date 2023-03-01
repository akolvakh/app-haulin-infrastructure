## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_sns_topic_policy.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_iam_policy_document.sns_topic_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | (Optional) The ID of the account. | `string` | `""` | no |
| <a name="input_app"></a> [app](#input\_app) | (Required) App name. | `string` | n/a | yes |
| <a name="input_arn"></a> [arn](#input\_arn) | (Required) The ARN of the SNS topic. | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | (Required) Environment. | `string` | n/a | yes |
| <a name="input_policy"></a> [policy](#input\_policy) | (Required) The fully-formed AWS policy as JSON. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide. | `string` | n/a | yes |

## Outputs

No outputs.
