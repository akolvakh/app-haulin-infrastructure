#------------------------------------------------------------------------------
# General
#------------------------------------------------------------------------------
resource "random_string" "suffix" {
  length  = 8
  special = false
}

#------------------------------------------------------------------------------
# Security group
#------------------------------------------------------------------------------
resource "aws_security_group" "default" {
  vpc_id                 = var.security_group_vpc_id
  name                   = var.security_group_name
  description            = var.security_group_description
  revoke_rules_on_delete = var.security_group_revoke_rules_on_delete

  tags = {
    Name        = "${var.app}-${var.env}-sg-${random_string.suffix.result}"
    Terraform   = true
    App         = var.app
    Environment = "${var.app}-${var.env}"
  }
}

resource "aws_security_group_rule" "ingress" {
  count             = var.is_ingress ? length(var.ingress_rules) : 0
  type              = "ingress"
  from_port         = var.ingress_rules[count.index].from_port
  to_port           = var.ingress_rules[count.index].to_port
  protocol          = var.ingress_rules[count.index].protocol
  cidr_blocks       = [var.ingress_rules[count.index].cidr_block]
  description       = var.ingress_rules[count.index].description
  security_group_id = var.ingress_rules[count.index].sg_source

  #ToDo
  //self              = var.ingress_self
}

resource "aws_security_group_rule" "egress" {
  count             = var.is_egress ? length(var.egress_rules) : 0
  type              = "egress"
  from_port         = var.egress_rules[count.index].from_port
  to_port           = var.egress_rules[count.index].to_port
  protocol          = var.egress_rules[count.index].protocol
  cidr_blocks       = [var.egress_rules[count.index].cidr_block]
  description       = var.egress_rules[count.index].description
  security_group_id = var.egress_rules[count.index].sg_source
}
