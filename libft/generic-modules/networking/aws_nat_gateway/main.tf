#------------------------------------------------------------------------------
# General
#------------------------------------------------------------------------------
resource "random_string" "suffix" {
  length  = 8
  special = false
}

#------------------------------------------------------------------------------
# NAT Gateway
#------------------------------------------------------------------------------
resource "aws_eip" "nat_gateway" {
  vpc = true

  tags = {
    Name        = "${var.app}-${var.env}-nat-gateway-eip-${random_string.suffix.result}"
    Terraform   = true
    App         = var.app
    Environment = "${var.app}-${var.env}"
  }
}

resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = var.subnet_id

  tags = {
    Name        = "${var.app}-${var.env}-nat-gateway-${random_string.suffix.result}"
    Terraform   = true
    App         = var.app
    Environment = "${var.app}-${var.env}"
  }
}

#------------------------------------------------------------------------------
# Route to the internet
#------------------------------------------------------------------------------
resource "aws_route" "route" {
  route_table_id         = var.route_table_id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.gw.id
}
