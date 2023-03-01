#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    {
      "Name" = join(
        ".",
        [
          local.common.Product,
          local.common.Environment,
          var.tag_description,
        ],
      )
      "Description" = var.tag_description
    },
    local.common_tags,
    var.vpc_additional_tags,
  )

  lifecycle {
    create_before_destroy = true
  }
}
