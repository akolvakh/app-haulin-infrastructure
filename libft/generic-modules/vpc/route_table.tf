# privat subnets routing
resource "aws_route_table" "private_route_table" {
  count  = length(local.private_subnets)
  vpc_id = aws_vpc.main.id

  tags = merge(
    {
      "Name" = join(
        ".",
        [
          local.common.Product,
          local.common.Environment,
          "private_routes",
        ],
      )
      "Description" = "Routes for private subnets"
    },
    local.private_subnets[count.index].tags,
    local.common_tags,
    var.vpc_additional_tags
  )
}

resource "aws_route" "private_route" {
  count                  = var.create_nat ? length(local.private_subnets) : 0
  route_table_id         = element(aws_route_table.private_route_table.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nat.*.id, count.index)
}

resource "aws_route" "private_route_2_peer" {
  count                     = var.peer_vpc_enable ? length(local.private_subnets) : 0
  route_table_id            = element(aws_route_table.private_route_table.*.id, count.index)
  destination_cidr_block    = var.peer_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.to_vpn[0].id
}

resource "aws_route_table_association" "private_rt_assoc" {
  count          = length(local.private_subnets)
  subnet_id      = element(aws_subnet.private_subnets.*.id, count.index)
  route_table_id = element(aws_route_table.private_route_table.*.id, count.index)
}


#public routes
resource "aws_route_table" "public_route_table" {
  count  = length(local.public_subnets)
  vpc_id = aws_vpc.main.id

  tags = merge(
    {
      "Name" = join(
        ".",
        [
          local.common.Product,
          local.common.Environment,
          "public_routes",
        ],
      )
      "Description" = "Public Routes"
    },
    local.public_subnets[count.index].tags,
    local.common_tags,
    var.vpc_additional_tags
  )
}

resource "aws_route" "public_route" {
  count                  = length(local.public_subnets)
  route_table_id         = element(aws_route_table.public_route_table.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}
resource "aws_route" "public_route_2_peer" {
  count                     = var.peer_vpc_enable ? length(local.public_subnets) : 0
  route_table_id            = element(aws_route_table.public_route_table.*.id, count.index)
  destination_cidr_block    = var.peer_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.to_vpn[0].id
}



resource "aws_route_table_association" "public_rt_assoc" {
  count          = length(local.public_subnets)
  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = element(aws_route_table.public_route_table.*.id, count.index)
}

