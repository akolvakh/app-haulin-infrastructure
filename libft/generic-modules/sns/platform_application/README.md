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
| [aws_sns_platform_application.apns_application](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_platform_application) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app"></a> [app](#input\_app) | (Required) App name. | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | (Required) Environment. | `string` | n/a | yes |
| <a name="input_event_delivery_failure_topic_arn"></a> [event\_delivery\_failure\_topic\_arn](#input\_event\_delivery\_failure\_topic\_arn) | (Optional) SNS Topic triggered when a delivery to any of the platform endpoints associated with your platform application encounters a permanent failure. | `string` | `""` | no |
| <a name="input_event_endpoint_created_topic_arn"></a> [event\_endpoint\_created\_topic\_arn](#input\_event\_endpoint\_created\_topic\_arn) | (Optional) SNS Topic triggered when a new platform endpoint is added to your platform application. | `string` | `""` | no |
| <a name="input_event_endpoint_deleted_topic_arn"></a> [event\_endpoint\_deleted\_topic\_arn](#input\_event\_endpoint\_deleted\_topic\_arn) | (Optional) SNS Topic triggered when an existing platform endpoint is deleted from your platform application. | `string` | `""` | no |
| <a name="input_event_endpoint_updated_topic_arn"></a> [event\_endpoint\_updated\_topic\_arn](#input\_event\_endpoint\_updated\_topic\_arn) | (Optional) SNS Topic triggered when an existing platform endpoint is changed from your platform application. | `string` | `""` | no |
| <a name="input_failure_feedback_role_arn"></a> [failure\_feedback\_role\_arn](#input\_failure\_feedback\_role\_arn) | (Optional) The IAM role permitted to receive failure feedback for this application. | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The friendly name for the SNS platform application. | `string` | n/a | yes |
| <a name="input_platform"></a> [platform](#input\_platform) | (Required) The platform that the app is registered with. See Platform for supported platforms. | `string` | n/a | yes |
| <a name="input_platform_credential"></a> [platform\_credential](#input\_platform\_credential) | (Required) Application Platform credential. See Credential for type of credential required for platform. The value of this attribute when stored into the Terraform state is only a hash of the real value, so therefore it is not practical to use this as an attribute for other resources. | `string` | n/a | yes |
| <a name="input_platform_principal"></a> [platform\_principal](#input\_platform\_principal) | (Optional) Application Platform principal. See Principal for type of principal required for platform. The value of this attribute when stored into the Terraform state is only a hash of the real value, so therefore it is not practical to use this as an attribute for other resources. | `string` | `""` | no |
| <a name="input_success_feedback_role_arn"></a> [success\_feedback\_role\_arn](#input\_success\_feedback\_role\_arn) | (Optional) The IAM role permitted to receive success feedback for this application. | `string` | `""` | no |
| <a name="input_success_feedback_sample_rate"></a> [success\_feedback\_sample\_rate](#input\_success\_feedback\_sample\_rate) | (Optional) The percentage of success to sample (0-100). | `number` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the SNS platform application. |
| <a name="output_id"></a> [id](#output\_id) | The ARN of the SNS platform application. |
