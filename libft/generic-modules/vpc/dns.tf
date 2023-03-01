#--------------------------------------------------------------
# Private Hosted Forward Lookup Zone
#--------------------------------------------------------------
resource "aws_route53_zone" "vpc_private_zone" {
  name = var.private_hosted_domain
  comment = "VPC ${join(
    ".",
    [
      local.common.Product,
      local.common.Environment,
      var.tag_description,
    ],
  )} private zone"

  vpc {
    vpc_id = aws_vpc.main.id
  }

  lifecycle {
    ignore_changes = [vpc]
  }

  tags = merge(
    {
      "Name" = join(
        ".",
        [
          local.common.Product,
          local.common.Environment,
          "route53_private_zone",
        ],
      )
      "Description" = "private dns zone in Route53"
    },
    local.common_tags,
    var.vpc_additional_tags,
  )
}

#--------------------------------------------------------------
# Reverse Lookup for private Zone
#--------------------------------------------------------------
resource "aws_route53_zone" "reverse_lookup_zone" {
  name    = "${element(split(".", var.vpc_cidr_block), 1)}.${element(split(".", var.vpc_cidr_block), 0)}.in-addr.arpa"
  comment = "VPC ${join(".", [local.common.Product, local.common.Environment, var.tag_description, ], )} reverse lookup zone"

  vpc {
    vpc_id = aws_vpc.main.id
  }

  lifecycle {
    ignore_changes = [vpc]
  }

  tags = merge(
    {
      "Name" = join(
        ".",
        [
          local.common.Product,
          local.common.Environment,
          "route53_reverse_lookup_zone",
        ],
      )
      "Description" = "route53_reverse_lookup_zone"
    },
    local.common_tags,
    var.vpc_additional_tags,
  )
}

/**
DHCP TBD?

*/
