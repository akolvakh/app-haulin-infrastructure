#public subnet
resource "aws_subnet" "public_subnets" {
  count                   = length(local.public_subnets)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(local.public_subnets, count.index).cidr
  availability_zone       = element(local.public_subnets, count.index).az
  map_public_ip_on_launch = true

  tags = merge(
    {
      "Name" = join(
        ".",
        [
          local.common.Product,
          local.common.Environment,
          element(local.public_subnets, count.index).name,
          "public_subnet",
          count.index
        ],
      )
      "Description" = "public subnets"
    },
    local.common_tags,
    var.vpc_additional_tags,
    element(local.public_subnets, count.index).tags
  )


}

#-pvt subnets
resource "aws_subnet" "private_subnets" {
  count                   = length(local.private_subnets)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(local.private_subnets, count.index).cidr
  availability_zone       = element(local.private_subnets, count.index).az
  map_public_ip_on_launch = false

  tags = merge(
    {
      "Name" = join(
        ".",
        [
          local.common.Product,
          local.common.Environment,
          element(local.private_subnets, count.index).name,
          "private_subnet",
          count.index
        ],
      )
      "Description" = "Private subnets"
    },
    local.common_tags,
    var.vpc_additional_tags,
    element(local.private_subnets, count.index).tags
  )
}

