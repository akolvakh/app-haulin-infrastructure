resource "aws_eip" "nlb" {
  count = length(var.alb_public_ips) > 0 ? 0 : 2
  vpc   = true
  lifecycle {
    prevent_destroy = true
  }
  tags = merge(local.common_tags, { Role = var.tag_role, Name = join(".", [local.name_prefix, var.tag_role]) })
}
locals {
  public_ips = length(var.alb_public_ips) > 0 ? var.alb_public_ips : aws_eip.nlb.*.id
}

resource "aws_lb" "nlb" {
  name               = substr(join("-", [local.name_prefix, var.tag_role]), 0, 32)
  load_balancer_type = "network"
  //NLB does not have IP whitelsit per se - it transparently transfers traffic to targets (Zytra ALB) this case and we use IP whitelist at the target
  dynamic "subnet_mapping" {
    for_each = zipmap(local.public_ips, slice(tolist(var.alb_subnets), 0, length(local.public_ips)))
    content {
      allocation_id = subnet_mapping.key
      subnet_id     = subnet_mapping.value

    }

  }

  tags = merge(local.common_tags, { "role" = var.tag_role })

}
