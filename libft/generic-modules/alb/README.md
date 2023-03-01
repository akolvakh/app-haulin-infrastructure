## Requirements

(Optional) ARN of AWS Certificate Manager certificate.

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
| [aws_lb.lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener_rule.api_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_listener_rule.web_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_target_group.api_tgt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.web_tgt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [random_id.alb_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_access_log_bucket"></a> [alb\_access\_log\_bucket](#input\_alb\_access\_log\_bucket) | s3 bucket name to store  access logs in | `string` | `""` | no |
| <a name="input_alb_access_log_enable"></a> [alb\_access\_log\_enable](#input\_alb\_access\_log\_enable) | enable access logging into S3 bucket? | `bool` | `false` | no |
| <a name="input_alb_access_log_prefix"></a> [alb\_access\_log\_prefix](#input\_alb\_access\_log\_prefix) | prefix where to store access lgos in the S3 bucket | `string` | `""` | no |
| <a name="input_alb_additional_tags"></a> [alb\_additional\_tags](#input\_alb\_additional\_tags) | A map of additional tags, just tag/value pairs, to add to the VPC. | `map(string)` | `{}` | no |
| <a name="input_alb_http2_enable"></a> [alb\_http2\_enable](#input\_alb\_http2\_enable) | enable HTTP/2 support in load balancer | `bool` | `false` | no |
| <a name="input_alb_internal_enable"></a> [alb\_internal\_enable](#input\_alb\_internal\_enable) | shall ALB be accessible from VPC only/have private IP only? | `bool` | n/a | yes |
| <a name="input_alb_security_groups"></a> [alb\_security\_groups](#input\_alb\_security\_groups) | what security groups to assign to the ALB, list of ID | `list(string)` | n/a | yes |
| <a name="input_alb_subnets"></a> [alb\_subnets](#input\_alb\_subnets) | subnets where the ALB being created to live in | `list(string)` | n/a | yes |
| <a name="input_alb_type"></a> [alb\_type](#input\_alb\_type) | allowed values = application\|network | `string` | `"application"` | no |
| <a name="input_alb_vpc_id"></a> [alb\_vpc\_id](#input\_alb\_vpc\_id) | VPC where the ALB being created to live in | `string` | n/a | yes |
| <a name="input_backends_api"></a> [backends\_api](#input\_backends\_api) | names of backends to be exposed via ALB. prefix\_api will be prepended to matching rules. Can be '/'. Listner rules and target groups will be auto created. Sample: backend\_name = /auth, prefix\_api=api, requests for <DNS>/api/auth to be routed to tgt grp 'arn:...auth' | `list(string)` | `[]` | no |
| <a name="input_backends_web"></a> [backends\_web](#input\_backends\_web) | names of backends to be exposed via ALB. prefix\_web will be prepended to matching rules. Can be '/'. Listner rules and target groups will be auto created. Sample: backend\_name = /experimnent, prefix\_web=/web, requests for <DNS>/web/experiment to be routed to tgt grp 'arn:...:experiment' | `list(string)` | `[]` | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | (Optional) ARN of the default SSL server certificate. Exactly one certificate is required if the protocol is HTTPS. For adding additional SSL certificates, see the aws\_lb\_listener\_certificate resource | `string` | `null` | no |
| <a name="input_http_port"></a> [http\_port](#input\_http\_port) | What port listen on HTTP protocol if any. | `string` | `80` | no |
| <a name="input_https_port"></a> [https\_port](#input\_https\_port) | What port listen on HTTPS protocol if any. | `string` | `443` | no |
| <a name="input_prefix_api"></a> [prefix\_api](#input\_prefix\_api) | URI prefix for api(s) | `string` | `"/api"` | no |
| <a name="input_prefix_web"></a> [prefix\_web](#input\_prefix\_web) | URI prefix for web applications. | `string` | `""` | no |
| <a name="input_ssl_policy"></a> [ssl\_policy](#input\_ssl\_policy) | https://docs.aws.amazon.com/elasticloadbalancing/latest/application/create-https-listener.html#describe-ssl-policies | `string` | `"ELBSecurityPolicy-2016-08"` | no |
| <a name="input_tag_contact"></a> [tag\_contact](#input\_tag\_contact) | Who to reach with questions and requests for this resource? Should be valid email address | `string` | n/a | yes |
| <a name="input_tag_description"></a> [tag\_description](#input\_tag\_description) | Few meaningful words, to describe what this resource does | `string` | n/a | yes |
| <a name="input_tag_environment"></a> [tag\_environment](#input\_tag\_environment) | Environment. Sample : dev,staging,prod | `string` | n/a | yes |
| <a name="input_tag_orchestration"></a> [tag\_orchestration](#input\_tag\_orchestration) | Where in git we find TF code controlling/instantiating this module? | `string` | n/a | yes |
| <a name="input_tag_product"></a> [tag\_product](#input\_tag\_product) | Sample: phoenix-phoenix-app. | `string` | n/a | yes |
| <a name="input_tag_role"></a> [tag\_role](#input\_tag\_role) | Sample: admin-lb | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_arn"></a> [alb\_arn](#output\_alb\_arn) | The ARN of the load balancer |
| <a name="output_alb_backends_api_name_2_tgt_arn"></a> [alb\_backends\_api\_name\_2\_tgt\_arn](#output\_alb\_backends\_api\_name\_2\_tgt\_arn) | map of path\_prefix=>target\_group\_arn. To be used for deployment. Lookup target grp to attach your ECS service to, via terraform remote\_state |
| <a name="output_alb_backends_web_name_2_tgt_arn"></a> [alb\_backends\_web\_name\_2\_tgt\_arn](#output\_alb\_backends\_web\_name\_2\_tgt\_arn) | map of path\_prefix=>target\_group\_arn. To be used for deployment. Lookup target grp to attach your ECS service to, via terraform remote\_state |
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | The DNS name of the load balancer |
| <a name="output_alb_hosted_zone_id"></a> [alb\_hosted\_zone\_id](#output\_alb\_hosted\_zone\_id) | hosted zone ID of the load balancer (to be used in a Route 53 Alias record) |
| <a name="output_alb_id"></a> [alb\_id](#output\_alb\_id) | The ID of the load balancer |
| <a name="output_alb_security_groups"></a> [alb\_security\_groups](#output\_alb\_security\_groups) | security groups assigned to the ALB |
