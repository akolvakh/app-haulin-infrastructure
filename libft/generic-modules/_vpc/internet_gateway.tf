resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    {
      "Name" = join(
        ".",
        [
          local.common.Product,
          local.common.Environment,
          "internet_gateway",
        ],
      )
      "Description" = "Internet gateway for the VPC"
    },
    local.common_tags,
    var.vpc_additional_tags,
  )
}

