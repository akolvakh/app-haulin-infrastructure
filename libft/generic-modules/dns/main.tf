resource "aws_route53_zone" "zone" {
  name = var.domain

  dynamic "vpc" {
    for_each = { for id in var.vpc_ids : id => id }

    content {
      vpc_id = vpc.value
    }
  }

  comment = "DNS ${join(
    ".",
    [
      var.tag_product,
      var.tag_environment,
      var.tag_description,
    ],
  )} ${length(var.vpc_ids) > 0 ? "private" : "public"} zone"

  tags = merge(
    {
      "Name" = join(
        ".",
        [
          var.tag_product,
          var.tag_environment,
          "route53_${length(var.vpc_ids) > 0 ? "private" : "public"} _zone",
        ],
      )
      "Description" = "${length(var.vpc_ids) > 0 ? "private" : "public"}  dns zone in Route53"
    },
    local.common_tags,
    var.dns_additional_tags,
  )
}

############################
# TBD reverse zone
############################