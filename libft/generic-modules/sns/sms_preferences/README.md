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
| [aws_sns_sms_preferences.update_sms_prefs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_sms_preferences) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app"></a> [app](#input\_app) | (Required) App name. | `string` | n/a | yes |
| <a name="input_default_sender_id"></a> [default\_sender\_id](#input\_default\_sender\_id) | (Optional) A string, such as your business brand, that is displayed as the sender on the receiving device. | `string` | `""` | no |
| <a name="input_default_sms_type"></a> [default\_sms\_type](#input\_default\_sms\_type) | (Optional) The type of SMS message that you will send by default. Possible values are: Promotional, Transactional. | `string` | `""` | no |
| <a name="input_delivery_status_iam_role_arn"></a> [delivery\_status\_iam\_role\_arn](#input\_delivery\_status\_iam\_role\_arn) | (Optional) The ARN of the IAM role that allows Amazon SNS to write logs about SMS deliveries in CloudWatch Logs. | `string` | `""` | no |
| <a name="input_delivery_status_success_sampling_rate"></a> [delivery\_status\_success\_sampling\_rate](#input\_delivery\_status\_success\_sampling\_rate) | (Optional) The percentage of successful SMS deliveries for which Amazon SNS will write logs in CloudWatch Logs. The value must be between 0 and 100. | `number` | `""` | no |
| <a name="input_env"></a> [env](#input\_env) | (Required) Environment. | `string` | n/a | yes |
| <a name="input_monthly_spend_limit"></a> [monthly\_spend\_limit](#input\_monthly\_spend\_limit) | (Optional) The maximum amount in USD that you are willing to spend each month to send SMS messages. | `string` | `""` | no |
| <a name="input_usage_report_s3_bucket"></a> [usage\_report\_s3\_bucket](#input\_usage\_report\_s3\_bucket) | (Optional) The name of the Amazon S3 bucket to receive daily SMS usage reports from Amazon SNS. | `string` | `""` | no |

## Outputs

No outputs.
