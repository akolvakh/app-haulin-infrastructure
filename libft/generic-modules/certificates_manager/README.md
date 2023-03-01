# Certificate manager Terraform Module for phoenix #

This Terraform module creates the base certificate manager infrastructure on AWS for phoenix App.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name      | Version |
|-----------|---------|
| terraform | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| aws  | n/a     |


## Resources

| Name |
|------|
|  |
|  |

## Structure
This module consists of next submodules (resources):
1. `submodule`
2. `resource`


## Usage

You can use this module to create a ...

### Example (resources)

This simple example creates a ... :

```

```


Certificate creation
```
resource "aws_acm_certificate" "cert" {
  domain_name       = "example.com"
  validation_method = "DNS"

  tags = {
    Environment = "test"
  }

  lifecycle {
    create_before_destroy = true
  }
}
```

Importing an existing certificate
```
resource "tls_private_key" "example" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "example" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.example.private_key_pem

  subject {
    common_name  = "example.com"
    organization = "ACME Examples, Inc"
  }

  validity_period_hours = 12

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "aws_acm_certificate" "cert" {
  private_key      = tls_private_key.example.private_key_pem
  certificate_body = tls_self_signed_cert.example.cert_pem
}
```

Referencing domain_validation_options With for_each Based Resources
```
resource "aws_route53_record" "example" {
  for_each = {
    for dvo in aws_acm_certificate.example.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.example.zone_id
}
```

This simple example creates a acm certificate validation :

DNS Validation with Route 53
```
resource "aws_acm_certificate" "example" {
  domain_name       = "example.com"
  validation_method = "DNS"
}

data "aws_route53_zone" "example" {
  name         = "example.com"
  private_zone = false
}

resource "aws_route53_record" "example" {
  for_each = {
    for dvo in aws_acm_certificate.example.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.example.zone_id
}

resource "aws_acm_certificate_validation" "example" {
  certificate_arn         = aws_acm_certificate.example.arn
  validation_record_fqdns = [for record in aws_route53_record.example : record.fqdn]
}

resource "aws_lb_listener" "example" {
  # ... other configuration ...

  certificate_arn = aws_acm_certificate_validation.example.certificate_arn
}
```

Alternative Domains DNS Validation with Route 53
```
resource "aws_acm_certificate" "example" {
  domain_name               = "example.com"
  subject_alternative_names = ["www.example.com", "example.org"]
  validation_method         = "DNS"
}

data "aws_route53_zone" "example_com" {
  name         = "example.com"
  private_zone = false
}

data "aws_route53_zone" "example_org" {
  name         = "example.org"
  private_zone = false
}

resource "aws_route53_record" "example" {
  for_each = {
    for dvo in aws_acm_certificate.example.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      record  = dvo.resource_record_value
      type    = dvo.resource_record_type
      zone_id = dvo.domain_name == "example.org" ? data.aws_route53_zone.example_org.zone_id : data.aws_route53_zone.example_com.zone_id
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = each.value.zone_id
}

resource "aws_acm_certificate_validation" "example" {
  certificate_arn         = aws_acm_certificate.example.arn
  validation_record_fqdns = [for record in aws_route53_record.example : record.fqdn]
}

resource "aws_lb_listener" "example" {
  # ... other configuration ...

  certificate_arn = aws_acm_certificate_validation.example.certificate_arn
}
```

Email Validation
```
resource "aws_acm_certificate" "example" {
  domain_name       = "example.com"
  validation_method = "EMAIL"
}

resource "aws_acm_certificate_validation" "example" {
  certificate_arn = aws_acm_certificate.example.arn
}
```


### Example (module)

This more complete example creates a certificates manager module using a detailed configuration. Please check the example folder to get the example with all options:

```
module "certificate-manager" {
  source = "./aliases/certificates_manager"

  app                                 = "phoenix"
  env                                 = "dev"
  domain_name                         = "phoenix.com"
  process_domain_validation_options   = true
  ttl                                 = "300"
  subject_alternative_names           = ["*.phoenix.com"]
  cmv_certificate_arn                 = "arn:aws:iam::123456789012:user/Development/product_12345/*"
  private_certificate_authority_arn   = "arn:aws:iam::123456789012:user/Development/product_12345/*"
  private_domain_name                 = "www.phoenix.com"
  certificate_body                    = "certificates body"
  hosted_zone_id                      = module.route53.zone_id
  private_key                         = "private-key"
}
```


## Inputs

| Name                                 | Description                                                                                                                                                                                                                                                                                                                    | Type          | Default       | Required |
|--------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|---------------|----------|
| app                                  | App name                                                                                                                                                                                                                                                                                                                       | `string`      | n/a     | yes      |
| env                                  | Environment                                                                                                                                                                                                                                                                                                                    | `string`      | n/a        | yes      |
| enabled                                  | Whether to create an amazon issued certificate                                                                                                                                                                                                                                                                                                                    | `bool`      | `true`        | no      |
| private_enabled                                  | Whether to creating a private CA issued certificate                                                                                                                                                                                                                                                                                                                    | `bool`      | `false`        | no      |
| importing_enabled                                  | Whether to import an existing certificate                                                                                                                                                                                                                                                                                                                    | `bool`      | `false`        | no      |
| process_domain_validation_options                                  | Flag to enable/disable processing of the record to add to the DNS zone to complete certificate validation                                                                                                                                                                                                                                                                                                                    | `bool`      | `true`        | no      |
| wait_for_certificate_issued                                  | Whether to wait for the certificate to be issued by ACM (the certificate status changed from `Pending Validation` to `Issued`)                                                                                                                                                                                                                                                                                                                    | `bool`      | `false`        | no      |
| zone_name                                  | Name of the zone                                                                                                                                                                                                                                                                                                                    | `string`      | "phoenix.com"        | no      |
| hosted_zone_id                                  | Route 53 Zone ID for DNS validation records                                                                                                                                                                                                                                                                                                                    | `string`      | n/a        | yes      |
| ttl                                  | The TTL of the record to add to the DNS zone to complete certificate validation                                                                                                                                                                                                                                                                                                                    | `string`      | "300"        | no      |
| cert_tags                                  | A map of tags to assign to the resource                                                                                                                                                                                                                                                                                                                    | `map(string)`      | n/a        | no      |
| domain_name                                  | A domain name for which the certificate should be issued                                                                                                                                                                                                                                                                                                                    | `string`      | n/a        | yes      |
| subject_alternative_names                                  | Set of domains that should be SANs in the issued certificate. To remove all elements of a previously configured list, set this value equal to an empty list ([]) or use the terraform taint command to trigger recreation                                                                                                                                                                                                                                                                                                                    | `list(string)`      | []        | no      |
| validation_method                                  | Which method to use for validation. DNS or EMAIL are valid, NONE can be used for certificates that were imported into ACM and then into Terraform                                                                                                                                                                                                                                                                                                                       | `string`      | n/a     | yes      |
| private_key                                  |The certificate's PEM-formatted private key| `string`      | n/a     | yes      |
| certificate_body                                  |The certificate's PEM-formatted public key| `string`      | n/a     | yes      |
| certificate_chain                                  |The certificate's PEM-formatted chain| `string`      | "/"     | no      |
| private_domain_name                                  |A domain name for which the certificate should be issued| `string`      | n/a     | yes      |
| private_certificate_authority_arn                                  |ARN of an ACMPCA| `string`      | n/a     | yes      |
| private_subject_alternative_names                                  |Set of domains that should be SANs in the issued certificate. To remove all elements of a previously configured list, set this value equal to an empty list ([]) or use the terraform taint command to trigger recreation| `list(string)`      | []    | no      |
| certificate_transparency_logging_preference                                  |Specifies whether certificate details should be added to a certificate transparency log. Valid values are ENABLED or DISABLED| `string`      | "DISABLED"    | no      |
| cmv_certificate_arn                                  |The ARN of the certificate that is being validated| `string`      | n/a        | yes      |
| cmv_validation_record_fqdns                                  |List of FQDNs that implement the validation. Only valid for DNS validation method ACM certificates. If this is set, the resource can implement additional sanity checks and has an explicit dependency on the resource that is implementing the validation| `list(string)`      | []        | no      |


## Outputs

| Name                          | Description                                                                               |
|-------------------------------|-------------------------------------------------------------------------------------------|
| cert_id                        |The ARN of the certificate|
| cert_arn                       |The ARN of the certificate|
| cert_domain_name                | The domain name for which the certificate is issued                                            |
| cert_domain_validation_options                  |Set of domain validation objects which can be used to complete certificate validation. Can have more than one element, e.g. if SANs are defined. Only set if DNS-validation was used|
| cert_status                   |Status of the certificate|
| cert_validation_emails |A list of addresses that received a validation E-Mail. Only set if EMAIL-validation was used|
|cmv_id| The time at which the certificate was issued                                                         |
|*domain_validation_domain_name|The domain to be validated                                                                                           |
|*domain_validation_resource_record_name| The name of the DNS record to create to validate the certificate                                                         |
|*domain_validation_resource_record_type| The type of DNS record to create                                                         |
|*domain_validation_resource_record_value| The value the DNS record needs to have                                                         |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
