// extendable code copy ref https://github.com/hashicorp/terraform-cidr-subnets/blob/master/main.tf
// ref https://www.terraform.io/docs/language/functions/cidrsubnets.html

locals {
  module_version = "0.0.1"
  networks_zipped_2_azs = flatten([for net in var.networks : [
    for r in range(0, (null == lookup(net, "redundancy", null)) ? 1 : net["redundancy"]) : {
      "name"       = net["name"]
      "net_bits"   = net["add_net_bits"]
      "az"         = (null == lookup(net, "az", null)) ? var.availability_zones[r] : net["az"]
      "tags"       = (null == lookup(net, "tags", null)) ? {} : net["tags"]
      "is_private" = (null == lookup(net, "is_private", null)) ? true : net["is_private"]
    }
  ]])
  addrs_by_idx = cidrsubnets(var.vpc_cidr_block, local.networks_zipped_2_azs[*].net_bits...)
  network_objs = [for i, n in local.networks_zipped_2_azs : {
    net_bits   = n.net_bits
    az         = n.az
    tags       = (null == lookup(n, "tags", null)) ? {} : n.tags
    is_private = (null == lookup(n, "is_private", null)) ? true : n.is_private
    cidr       = local.addrs_by_idx[i]
    name       = n.name != null ? n.name : "deleted"
  }]
  public_subnets  = [for s in tolist(local.network_objs) : s if false == s.is_private]
  private_subnets = [for s in tolist(local.network_objs) : s if true == s.is_private]
  common = {
    Product       = data.aws_default_tags.default.tags["Product"]
    Contact       = data.aws_default_tags.default.tags["Contact"]
    Environment   = data.aws_default_tags.default.tags["Environment"]
    Orchestration = data.aws_default_tags.default.tags["Orchestration"]
  }
  common_tags = {
  }
}

