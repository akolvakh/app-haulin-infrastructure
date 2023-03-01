# Troubleshooting

#--------------------------------------------------------------
# Notes
#--------------------------------------------------------------
/**
* # Design intro
* - "microservice style" infra as code layout
* - terraform state separated into "layers", exposing outside "interfaces" via terraform remote state
* - to simplify dependencies tracking, layers down know nothing about layers on top.
* - modification of a layer should never require modifications of layer(s) down
* # DNS layer
* - stub for now, to be implementd on Cloudflare (or Route53)
* - mostly defines internet visible DNS name of the APP, base for URLs construction
* - as also private DNS visible name of Admin entry point
*/


# Design intro
- "microservice style" infra as code layout
- terraform state separated into "layers", exposing outside "interfaces" via terraform remote state
- to simplify dependencies tracking, layers down know nothing about layers on top.
- modification of a layer should never require modifications of layer(s) down
# DNS layer
- stub for now, to be implementd on Cloudflare (or Route53)
- mostly defines internet visible DNS name of the APP, base for URLs construction
- as also private DNS visible name of Admin entry point

## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `any` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `any` | n/a | yes |
| <a name="input_tag_orchestration"></a> [tag\_orchestration](#input\_tag\_orchestration) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_static_ip_admin_dns_name"></a> [static\_ip\_admin\_dns\_name](#output\_static\_ip\_admin\_dns\_name) | for vpn proxy service, DNS name associated with static IP addr for ADMIN. Should be VPNOnly |
| <a name="output_static_ip_admin_rest_dns_name"></a> [static\_ip\_admin\_rest\_dns\_name](#output\_static\_ip\_admin\_rest\_dns\_name) | for vpn proxy service, DNS name associated with static IP addr for ADMIN REST entry point(temp). Should be VPN |
| <a name="output_static_ip_app_dns_name"></a> [static\_ip\_app\_dns\_name](#output\_static\_ip\_app\_dns\_name) | for vpn proxy service, DNS name associated with static IP addr for APP. Should be VPN only in DEv/STtage. In Prod to not be used |
