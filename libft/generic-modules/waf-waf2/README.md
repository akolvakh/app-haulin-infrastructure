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
| [aws_wafv2_web_acl.my_web_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl) | resource |
| [aws_wafv2_web_acl_association.web_acl_association_my_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_waf_aggregate_key_type"></a> [waf\_aggregate\_key\_type](#input\_waf\_aggregate\_key\_type) | (Required) WAF Rule aggregate key type. | `string` | n/a | yes |
| <a name="input_waf_elb_arn"></a> [waf\_elb\_arn](#input\_waf\_elb\_arn) | (Required) Elb arn for WAF. | `string` | n/a | yes |
| <a name="input_waf_metric_name"></a> [waf\_metric\_name](#input\_waf\_metric\_name) | (Required) Metric name of the WAF. | `string` | n/a | yes |
| <a name="input_waf_name"></a> [waf\_name](#input\_waf\_name) | (Required) Name of the WAF. | `string` | n/a | yes |
| <a name="input_waf_priority"></a> [waf\_priority](#input\_waf\_priority) | (Required) WAF Rule Priority. | `number` | n/a | yes |
| <a name="input_waf_rate_limit"></a> [waf\_rate\_limit](#input\_waf\_rate\_limit) | (Required) WAF Rule rate limit. | `number` | n/a | yes |
| <a name="input_waf_scope"></a> [waf\_scope](#input\_waf\_scope) | (Required) WAF Scope. | `string` | n/a | yes |

## Outputs

No outputs.
