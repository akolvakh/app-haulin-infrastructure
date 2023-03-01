# Troubleshooting

#--------------------------------------------------------------
/**
* # Design intro
* - "microservice style" infra as code layout
* - terraform state separated into "layers", exposing outside "interfaces" via terraform remote state
* - to simplify dependencies tracking, layers down know nothing about layers on top.
* - modification of a layer should never require modifications of layer(s) down
* # Private DNS for VPN clients
* - WIP 
* - What it does in PRODUCT-app, should not it be inside VPN account/VPC?
*/
#--------------------------------------------------------------

# Design intro
- "microservice style" infra as code layout
- terraform state separated into "layers", exposing outside "interfaces" via terraform remote state
- to simplify dependencies tracking, layers down know nothing about layers on top.
- modification of a layer should never require modifications of layer(s) down
# Private DNS for VPN clients
- WIP
- What it does in PRODUCT-app, should not it be inside VPN account/VPC?

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
| [aws_route53_record.private_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `any` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `any` | n/a | yes |
| <a name="input_tag_orchestration"></a> [tag\_orchestration](#input\_tag\_orchestration) | n/a | `string` | `"https://github.com/PRODUCT/PRODUCT-infrastructure/blob/develop/deployments/PRODUCT-app-modularized/100.private_dns"` | no |

## Outputs

No outputs.
