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
| [aws_sns_topic_subscription.sns_topic_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app"></a> [app](#input\_app) | (Required) App name. | `string` | n/a | yes |
| <a name="input_confirmation_timeout_in_minutes"></a> [confirmation\_timeout\_in\_minutes](#input\_confirmation\_timeout\_in\_minutes) | (Optional) Integer indicating number of minutes to wait in retying mode for fetching subscription arn before marking it as failure. Only applicable for http and https protocols. Default is 1. | `string` | `""` | no |
| <a name="input_delivery_policy"></a> [delivery\_policy](#input\_delivery\_policy) | (Optional) JSON String with the delivery policy (retries, backoff, etc.) that will be used in the subscription - this only applies to HTTP/S subscriptions. Refer to the SNS docs for more details. | `string` | `""` | no |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | (Required) Endpoint to send data to. The contents vary with the protocol. See details below. | `string` | n/a | yes |
| <a name="input_endpoint_auto_confirms"></a> [endpoint\_auto\_confirms](#input\_endpoint\_auto\_confirms) | (Optional) Whether the endpoint is capable of auto confirming subscription (e.g., PagerDuty). Default is false. | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | (Required) Environment. | `string` | n/a | yes |
| <a name="input_filter_policy"></a> [filter\_policy](#input\_filter\_policy) | (Optional) JSON String with the filter policy that will be used in the subscription to filter messages seen by the target resource. Refer to the SNS docs for more details. | `string` | `""` | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | (Required) Protocol to use. Valid values are: sqs, sms, lambda, firehose, and application. Protocols email, email-json, http and https are also valid but partially supported. See details below. | `string` | n/a | yes |
| <a name="input_raw_message_delivery"></a> [raw\_message\_delivery](#input\_raw\_message\_delivery) | (Optional) Whether to enable raw message delivery (the original message is directly passed, not wrapped in JSON with the original message in the message property). Default is false. | `string` | `""` | no |
| <a name="input_redrive_policy"></a> [redrive\_policy](#input\_redrive\_policy) | (Optional) JSON String with the redrive policy that will be used in the subscription. Refer to the SNS docs for more details. | `string` | `""` | no |
| <a name="input_subscription_role_arn"></a> [subscription\_role\_arn](#input\_subscription\_role\_arn) | (Required if protocol is firehose) ARN of the IAM role to publish to Kinesis Data Firehose delivery stream. Refer to SNS docs. | `string` | `""` | no |
| <a name="input_topic_arn"></a> [topic\_arn](#input\_topic\_arn) | (Required) ARN of the SNS topic to subscribe to. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the subscription. |
| <a name="output_id"></a> [id](#output\_id) | ARN of the subscription. |
