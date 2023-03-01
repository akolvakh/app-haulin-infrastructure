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
| [aws_waf_byte_match_set.match_admin_url](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_byte_match_set) | resource |
| [aws_waf_byte_match_set.match_auth_tokens](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_byte_match_set) | resource |
| [aws_waf_byte_match_set.match_csrf_method](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_byte_match_set) | resource |
| [aws_waf_byte_match_set.match_php_insecure_uri](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_byte_match_set) | resource |
| [aws_waf_byte_match_set.match_php_insecure_var_refs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_byte_match_set) | resource |
| [aws_waf_byte_match_set.match_rfi_lfi_traversal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_byte_match_set) | resource |
| [aws_waf_byte_match_set.match_ssi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_byte_match_set) | resource |
| [aws_waf_ipset.admin_remote_ipset](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_ipset) | resource |
| [aws_waf_ipset.blacklisted_ips](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_ipset) | resource |
| [aws_waf_rule.detect_admin_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_rule) | resource |
| [aws_waf_rule.detect_bad_auth_tokens](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_rule) | resource |
| [aws_waf_rule.detect_blacklisted_ips](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_rule) | resource |
| [aws_waf_rule.detect_php_insecure](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_rule) | resource |
| [aws_waf_rule.detect_rfi_lfi_traversal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_rule) | resource |
| [aws_waf_rule.detect_ssi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_rule) | resource |
| [aws_waf_rule.enforce_csrf](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_rule) | resource |
| [aws_waf_rule.mitigate_sqli](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_rule) | resource |
| [aws_waf_rule.mitigate_xss](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_rule) | resource |
| [aws_waf_rule.restrict_sizes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_rule) | resource |
| [aws_waf_size_constraint_set.csrf_token_set](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_size_constraint_set) | resource |
| [aws_waf_size_constraint_set.size_restrictions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_size_constraint_set) | resource |
| [aws_waf_sql_injection_match_set.sql_injection_match_set](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_sql_injection_match_set) | resource |
| [aws_waf_web_acl.waf_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_web_acl) | resource |
| [aws_waf_xss_match_set.xss_match_set](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/waf_xss_match_set) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_remote_ipset"></a> [admin\_remote\_ipset](#input\_admin\_remote\_ipset) | List of IPs allowed to access admin pages, ['1.1.1.1/32', '2.2.2.2/32', '3.3.3.3/32'] | `list(string)` | `[]` | no |
| <a name="input_blacklisted_ips"></a> [blacklisted\_ips](#input\_blacklisted\_ips) | List of IPs to blacklist, eg ['1.1.1.1/32', '2.2.2.2/32', '3.3.3.3/32'] | `list(string)` | `[]` | no |
| <a name="input_rule_admin_access_action_type"></a> [rule\_admin\_access\_action\_type](#input\_rule\_admin\_access\_action\_type) | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | `string` | `"COUNT"` | no |
| <a name="input_rule_auth_tokens_action"></a> [rule\_auth\_tokens\_action](#input\_rule\_auth\_tokens\_action) | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | `string` | `"COUNT"` | no |
| <a name="input_rule_blacklisted_ips_action_type"></a> [rule\_blacklisted\_ips\_action\_type](#input\_rule\_blacklisted\_ips\_action\_type) | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | `string` | `"COUNT"` | no |
| <a name="input_rule_csrf_action_type"></a> [rule\_csrf\_action\_type](#input\_rule\_csrf\_action\_type) | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | `string` | `"COUNT"` | no |
| <a name="input_rule_csrf_header"></a> [rule\_csrf\_header](#input\_rule\_csrf\_header) | The name of your CSRF token header. | `string` | `"x-csrf-token"` | no |
| <a name="input_rule_lfi_rfi_action"></a> [rule\_lfi\_rfi\_action](#input\_rule\_lfi\_rfi\_action) | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | `string` | `"COUNT"` | no |
| <a name="input_rule_php_insecurities_action_type"></a> [rule\_php\_insecurities\_action\_type](#input\_rule\_php\_insecurities\_action\_type) | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | `string` | `"COUNT"` | no |
| <a name="input_rule_size_restriction_action_type"></a> [rule\_size\_restriction\_action\_type](#input\_rule\_size\_restriction\_action\_type) | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | `string` | `"COUNT"` | no |
| <a name="input_rule_sqli_action"></a> [rule\_sqli\_action](#input\_rule\_sqli\_action) | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | `string` | `"COUNT"` | no |
| <a name="input_rule_ssi_action_type"></a> [rule\_ssi\_action\_type](#input\_rule\_ssi\_action\_type) | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | `string` | `"COUNT"` | no |
| <a name="input_rule_xss_action"></a> [rule\_xss\_action](#input\_rule\_xss\_action) | Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing) | `string` | `"COUNT"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to all resources | `map(string)` | `{}` | no |
| <a name="input_waf_prefix"></a> [waf\_prefix](#input\_waf\_prefix) | Prefix to use when naming resources | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_web_acl_id"></a> [web\_acl\_id](#output\_web\_acl\_id) | AWS WAF web acl id. |
| <a name="output_web_acl_metric_name"></a> [web\_acl\_metric\_name](#output\_web\_acl\_metric\_name) | The name or description for the Amazon CloudWatch metric of this web ACL. |
| <a name="output_web_acl_name"></a> [web\_acl\_name](#output\_web\_acl\_name) | The name or description of the web ACL. |
