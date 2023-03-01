/**
NAT gateway in each public subnet? should be more tunable, to amend later
*/
resource "aws_eip" "nat" {
  count = var.create_nat ? min(length(local.public_subnets), var.nat_gateways_redundancy) : 0
  vpc   = true
  lifecycle {
    //prevent_destroy = true
  }
  tags = merge(
    {
      "Name" = join(
        ".",
        [local.common.Product, local.common.Environment, "eip_nat"],
      )
      "Description" = "NAT gateway public Elatic IP"
    },
    local.common_tags,
    var.vpc_additional_tags,
  )
}

resource "aws_nat_gateway" "nat" {
  count         = var.create_nat ? min(length(local.public_subnets), var.nat_gateways_redundancy) : 0
  allocation_id = element(aws_eip.nat.*.id, count.index)
  subnet_id     = element(aws_subnet.public_subnets.*.id, count.index)
  depends_on    = [aws_internet_gateway.gw]

  tags = merge(
    {
      "Name" = join(
        ".",
        [local.common.Product, local.common.Environment, "nat_gateway"],
      )
      "Description" = "NAT Gateway"
    },
    local.common_tags,
    var.vpc_additional_tags,
  )
}
