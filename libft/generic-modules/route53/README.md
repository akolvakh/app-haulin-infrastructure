# Route53 Terraform Module for phoenix #

This Terraform module creates the base route53 infrastructure on AWS for phoenix App.

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
1. `aws_route53_zone`
2. `aws_route53_record`
3. `aws_route53_zone_association`


## Usage

zone, record, association

You can use this module to create a ...

### Example (resources)

This simple example creates a route53 zone:

Public Zone
```
resource "aws_route53_zone" "primary" {
  name = "example.com"
}
```

Public Subdomain Zone
```
resource "aws_route53_zone" "main" {
  name = "example.com"
}

resource "aws_route53_zone" "dev" {
  name = "dev.example.com"

  tags = {
    Environment = "dev"
  }
}

resource "aws_route53_record" "dev-ns" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "dev.example.com"
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.dev.name_servers
}
```
Private Zone
```
resource "aws_route53_zone" "private" {
  name = "example.com"

  vpc {
    vpc_id = aws_vpc.example.id
  }
}
```

This simple example creates a route53 record:

Simple routing policy
```
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www.example.com"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.lb.public_ip]
}
```

Weighted routing policy
```
resource "aws_route53_record" "www-dev" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www"
  type    = "CNAME"
  ttl     = "5"

  weighted_routing_policy {
    weight = 10
  }

  set_identifier = "dev"
  records        = ["dev.example.com"]
}

resource "aws_route53_record" "www-live" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www"
  type    = "CNAME"
  ttl     = "5"

  weighted_routing_policy {
    weight = 90
  }

  set_identifier = "live"
  records        = ["live.example.com"]
}
```

Alias record
```
resource "aws_elb" "main" {
  name               = "foobar-terraform-elb"
  availability_zones = ["us-east-1c"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "example.com"
  type    = "A"

  alias {
    name                   = aws_elb.main.dns_name
    zone_id                = aws_elb.main.zone_id
    evaluate_target_health = true
  }
}
```

NS and SOA Record Management
```
resource "aws_route53_zone" "example" {
  name = "test.example.com"
}

resource "aws_route53_record" "example" {
  allow_overwrite = true
  name            = "test.example.com"
  ttl             = 30
  type            = "NS"
  zone_id         = aws_route53_zone.example.zone_id

  records = [
    aws_route53_zone.example.name_servers[0],
    aws_route53_zone.example.name_servers[1],
    aws_route53_zone.example.name_servers[2],
    aws_route53_zone.example.name_servers[3],
  ]
}
```

This simple example creates a route53 association:

```
resource "aws_vpc" "primary" {
  cidr_block           = "10.6.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_vpc" "secondary" {
  cidr_block           = "10.7.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_route53_zone" "example" {
  name = "example.com"

  # NOTE: The aws_route53_zone vpc argument accepts multiple configuration
  #       blocks. The below usage of the single vpc configuration, the
  #       lifecycle configuration, and the aws_route53_zone_association
  #       resource is for illustrative purposes (e.g. for a separate
  #       cross-account authorization process, which is not shown here).
  vpc {
    vpc_id = aws_vpc.primary.id
  }

  lifecycle {
    ignore_changes = [vpc]
  }
}

resource "aws_route53_zone_association" "secondary" {
  zone_id = aws_route53_zone.example.zone_id
  vpc_id  = aws_vpc.secondary.id
}
```

### Example (module)

This more complete example creates a route53 module using a detailed configuration. Please check the example folder to get the example with all options:

```
module "route53" {
  source = "./aliases/route53"

  name           = "route53"
  app    = "phoenix"
  env    = "dev"
  label_order    = ["environment", "name", "application"]
  public_enabled = true
  record_enabled = true

  latency_region = "/"
  alias_zone_id = "/"
  alias_name = "/"
  geolocation_country = "/"
  geolocation_continent = "/"
  alias_evaluate_target_health = false
  weight = 5
  failover_type = "/"
  zone_id = "/"


  domain_name = "phoenix.com"

  names = [
    "www.",
    "admin."
  ]
  types = [
    "A",
    "CNAME"
  ]
  alias = {
    names = [
      "d130easdsdsasd4js.cloudfront.net"
    ]
    zone_ids = [
      "Z2FDSDAASDASDER4"
    ]
    evaluate_target_healths = [
      false
    ]
  }
}
```


## Inputs

| Name                                 | Description                                                                                                                                                                                                                                                                                                                    | Type          | Default       | Required |
|--------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|---------------|----------|
| app                                  | App name                                                                                                                                                                                                                                                                                                                       | `string`      | "phoenix"      | yes      |
| env                                  | Environment                                                                                                                                                                                                                                                                                                                    | `string`      | "dev"         | yes      |
| private_enabled                                  | Whether to create private Route53 zone                                                                                                                                                                                                                                                                                                                    | `bool`      | `false`         | no      |
| record_enabled                                  | Whether to create Route53 record set                                                                                                                                                                                                                                                                                                                    | `bool`      | `false`         | no      |
| public_enabled                                  | Whether to create public Route53 zone                                                                                                                                                                                                                                                                                                                    | `bool`      | `false`         | no      |
| record_set_enabled                                  | Whether to create seperate Route53 record set                                                                                                                                                                                                                                                                                                                    | `bool`      | `false`         | no      |
| failover_enabled                                  | Whether to create Route53 record set                                                                                                                                                                                                                                                                                                                    | `bool`      | `false`         | no      |
| latency_enabled                                  | Whether to create Route53 record set                                                                                                                                                                                                                                                                                                                    | `bool`      | `false`         | no      |
| geolocation_enabled                                  | Whether to create Route53 record set                                                                                                                                                                                                                                                                                                                    | `bool`      | `false`         | no      |
| weighted_enabled                                  | Whether to create Route53 record set                                                                                                                                                                                                                                                                                                                    | `bool`      | `false`         | no      |
| domain_name                                  | This is the name of the hosted zone                                                                                                                                                                                                                                                                                                                    | `string`      | n/a         | yes      |
| comment                                  | A comment for the hosted zone. Defaults to 'Managed by Terraform'                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| delegation_set_id                                  | The ID of the reusable delegation set whose NS records you want to assign to the hosted zone. Conflicts with vpc as delegation sets can only be used for public zones                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| force_destroy                                  | Whether to destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone                                                                                                                                                                                                                                                                                                                    | `bool`      | `true`         | no      |
| tags                                  | A map of tags to assign to the zone                                                                                                                                                                                                                                                                                                                    | `map(string)`      |n/a| no      |
| vpc_id                                  | Configuration block(s) specifying VPC(s) to associate with a private hosted zone. Conflicts with the delegation_set_id argument in this resource and any aws_route53_zone_association resource specifying the same zone ID                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| vpc_region                                  | Region of the VPC to associate. Defaults to AWS provider region                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| zone_id                                  | The ID of the hosted zone to contain this record                                                                                                                                                                                                                                                                                                                    | `string`      | n/a         | yes      |
| names                                  | The name of the record                                                                                                                                                                                                                                                                                                                    | `list`      |[]| no      |
| types                                  | The record type. Valid values are A, AAAA, CAA, CNAME, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT                                                                                                                                                                                                                                                                                                                    | `list`      |[]| no      |
| ttls                                  | (Required for non-alias records) The TTL of the record                                                                                                                                                                                                                                                                                                                    | `list`      |[]| yes      |
| records                                  | (Required for non-alias records) A string list of records. To specify a single record value longer than 255 characters such as a TXT record for DKIM, add \"\" inside the Terraform configuration string (e.g. \"first255characters\"\"morecharacters\")                                                                                                                                                                                                                                                                                                                    | `list`      |[]| yes      |
| set_identifiers                                  | Unique identifier to differentiate records with routing policies from one another. Required if using failover, geolocation, latency, or weighted routing policies documented below                                                                                                                                                                                                                                                                                                                    | `list`      |[]| no      |
| health_check_ids                                  | The health check the record should be associated with                                                                                                                                                                                                                                                                                                                    | `list`      |[]| no      |
| alias                                  | An alias block. Conflicts with ttl & records. Alias record documented below                                                                                                                                                                                                                                                                                                                    | `map`      |n/a| no      |
| failover_routing_policies                                  | A block indicating the routing behavior when associated health check fails. Conflicts with any other routing policy. Documented below                                                                                                                                                                                                                                                                                                                    | `string`      | `null`        | no      |
| geolocation_routing_policies                                  | A block indicating a routing policy based on the geolocation of the requestor. Conflicts with any other routing policy. Documented below                                                                                                                                                                                                                                                                                                                    | `string`      |`null`| no      |
| latency_routing_policies                                  | A block indicating a routing policy based on the latency between the requestor and an AWS region. Conflicts with any other routing policy. Documented below                                                                                                                                                                                                                                                                                                                    | `string`      | `null`         | no      |
| weighted_routing_policies                                  | A block indicating a weighted routing policy. Conflicts with any other routing policy. Documented below                                                                                                                                                                                                                                                                                                                    | `string`      |`null`| no      |
| multivalue_answer_routing_policies                                  | Set to true to indicate a multivalue answer routing policy. Conflicts with any other routing policy                                                                                                                                                                                                                                                                                                                    | `list`      |[]| no      |
| allow_overwrites                                  | Allow creation of this record in Terraform to overwrite an existing record, if any. This does not affect the ability to update the record in Terraform and does not prevent other resources within Terraform or manual Route 53 changes outside Terraform from overwriting this record. false by default. This configuration is not recommended for most environments                                                                                                                                                                                                                                                                                                                    | `list`      |[]| no      |
| alias_name                                  | DNS domain name for a CloudFront distribution, S3 bucket, ELB, or another resource record set in this hosted zone                                                                                                                                                                                                                                                                                                                    | `string`      |n/a| yes      |
| alias_zone_id                                  | Hosted zone ID for a CloudFront distribution, S3 bucket, ELB, or Route 53 hosted zone. See resource_elb.zone_id for example                                                                                                                                                                                                                                                                                                                    | `string`      |n/a| yes      |
| alias_evaluate_target_health                                  | Set to true if you want Route 53 to determine whether to respond to DNS queries using this resource record set by checking the health of the resource record set. Some resources have special requirements                                                                                                                                                                                                                                                                                                                    | `bool`      |n/a| yes      |
| failover_type                                  | PRIMARY or SECONDARY. A PRIMARY record will be served if its healthcheck is passing, otherwise the SECONDARY will be served. See http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-configuring-options.html#dns-failover-failover-rrsets                                                                                                                                                                                                                                                                                                                    | `string`      |n/a| yes      |
| geolocation_continent                                  | A two-letter continent code. See http://docs.aws.amazon.com/Route53/latest/APIReference/API_GetGeoLocation.html for code details. Either continent or country must be specified                                                                                                                                                                                                                                                                                                                    | `string`      |n/a| yes      |
| geolocation_subdivision                                  | A subdivision code for a country                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| latency_region                                  | An AWS region from which to measure latency. See http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-policy.html#routing-policy-latency                                                                                                                                                                                                                                                                                                                    | `string`      |n/a| yes      |
| weight                                  | A numeric value indicating the relative weight of the record. See http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-policy.html#routing-policy-weighted                                                                                                                                                                                                                                                                                                                    | `number`      |n/a| yes      |
| vpc_acssociation_enabled                                  |  Whether to create Route53 vpc association                                                                                                                                                                                                                                                                                                                    | `bool`      |`false`| no      |
| secondary_vpc_id                                  | The VPC to associate with the private hosted zone                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| secondary_vpc_region                                  | The VPC's region. Defaults to the region of the AWS provider                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |


## Outputs

| Name                          | Description                                                                               |
|-------------------------------|-------------------------------------------------------------------------------------------|
| zone_id                        |The Hosted Zone ID. This can be referenced by zone records|
| name_servers                       |A list of name servers in associated (or default) delegation set. Find more about delegation sets in AWS docs|
|tags| A mapping of tags to assign to the resource                                            |
| record_name                  | The name of the record                                                         |
| record_fqdn                   |FQDN built using the zone domain and name|
| zone_association_id | The calculated unique identifier for the association                                            |
| zone_association_owning_account                    |         The account ID of the account that created the hosted zone                                                                                  |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
