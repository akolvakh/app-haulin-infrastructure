#--------------------------------------------------------------
# Notes
#--------------------------------------------------------------
#should be github link, with release tag



#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------
module "main_vpc" {
  source                = "../../../../../../libft/generic-modules/vpc" # can we have single root in terraform, all paths relative to this one root, like java import?
  vpc_name              = module.label.id
  vpc_cidr_block        = var.vpc_cidr
  private_hosted_domain = "${var.label["Environment"]}.${var.label["Product"]}.local"
  //it is safe add more networks, without disrupting infra layers on top. as far as you keep order intact and add to end.
  // when delete, to prevent disruption - put null into name field. range will be kept unallocated, other networks will be intact
  // name and add_net_bits are only required params
  networks = [
    {
      name         = "pub_lb"
      is_private   = false
      redundancy   = 2
      add_net_bits = 8
      tags         = { "type" = "public_loadbalancer" }
    },
    {
      name         = "priv_lb"
      redundancy   = 2
      add_net_bits = 8
      tags         = { "type" = "private_loadbalancer" }
    },
    { //https://aws.amazon.com/premiumsupport/knowledge-center/rds-launch-in-vpc/
      // want hve single AZ for non critical envs, to save costs - but AWS blocks it!
      name         = "db"
      add_net_bits = 8
      tags         = { "type" = "db", "cache" = "true" }
    },
    { //at least for elastic cache(shares same network with DB) we can go single AZ
      name         = "db"
      az           = (slice(data.aws_availability_zones.available.names, 0, 2))[1]
      add_net_bits = 8
      tags         = { "type" = "db", "cache" = local.is_single_az ? "false" : "true" }
    },
    { // "srv" and "*_lb" subnets to live in same AZs - AWS ALB requirement. The VPC module decides, what AZ place subnet into, by going throigh list of subnets, left to right, and picking up next available AZ from array of AZ, where index is wrapped/never out of array. netowrk[type=srv].redundancy to be <=network[type=lb].redundancy  or number of AZs available to be <=min(network[type=srv].redundancy,network[type=lb].redundancy)  
      name         = "srv"
      add_net_bits = 8
      tags         = { "type" = "service" }
    },
    {                                                  // "srv" and "*_lb" subnets to live in same AZs - AWS ALB requirement. The VPC module decides, what AZ place subnet into, by going throigh list of subnets, left to right, and picking up next available AZ from array of AZ, where index is wrapped/never out of array. netowrk[type=srv].redundancy to be <=network[type=lb].redundancy  or number of AZs available to be <=min(network[type=srv].redundancy,network[type=lb].redundancy)  
      name         = local.is_single_az ? null : "srv" //soft delete
      az           = (slice(data.aws_availability_zones.available.names, 0, 2))[1]
      add_net_bits = 8
      tags         = local.is_single_az ? { "type" = "null" } : { "type" = "service" }
    }
  ]
  //AWS regions have from 2 to 4 AZs(or more?) lets explicitly pickup first two, to have consistent results in any region
  availability_zones      = slice(data.aws_availability_zones.available.names, 0, 2)
  create_nat              = true
  //for all envs except prod- create just one NAT gateway to save costs, dont duplicate tem per AZ
  nat_gateways_redundancy = contains(["prod", "staging"], var.label["Environment"]) ? 2 : 1
  peer_vpc_enable         = false
  peer_account            = var.peer_account
  peer_region             = var.peer_region
  peer_vpc_id             = var.peer_vpc_id
  peer_vpc_cidr           = module.shared_config_cidr_vpn.vpn_vpc_cidr["primary"]
  tag_description         = "primary VPC, one for everything in ${module.label.tags["Product"]} APP stack"
  vpc_additional_tags     = {
#     "Jira"        = ""
     "vpn_peering" = "false"
   }
  label              = module.label.tags
}