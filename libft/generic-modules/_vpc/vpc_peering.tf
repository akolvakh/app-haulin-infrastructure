resource "aws_vpc_peering_connection" "to_vpn" {
  count         = var.peer_vpc_enable ? 1 : 0
  peer_owner_id = var.peer_account
  peer_region   = var.peer_region
  peer_vpc_id   = var.peer_vpc_id
  tags = merge(
    {
      "Name" = join(
        ".",
        [
          local.common.Product,
          local.common.Environment,
          "vpn_vpc_peering"
        ],
      )
      "Description" = "phoenix team VPNed access to ${local.common.Product} environment(s)"
    },
    local.common_tags,
    var.vpc_additional_tags,
  )
  vpc_id      = aws_vpc.main.id
  auto_accept = (var.peer_account == data.aws_caller_identity.current.account_id) ? true : false

}
