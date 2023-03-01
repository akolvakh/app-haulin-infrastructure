#------------------------------------------------------------------------------
# General
#------------------------------------------------------------------------------
resource "random_string" "suffix" {
  length  = 8
  special = false
}

#------------------------------------------------------------------------------
# VPC
#------------------------------------------------------------------------------
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  enable_dns_support   = var.vpc_enable_dns_support

  tags = {
    Name        = "${var.app}-${var.env}-vpc-${random_string.suffix.result}"
    Terraform   = true
    App         = var.app
    Environment = "${var.app}-${var.env}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

#------------------------------------------------------------------------------
# Internet gateway
#------------------------------------------------------------------------------
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.app}-${var.env}-gw-${random_string.suffix.result}"
    Terraform   = true
    App         = var.app
    Environment = "${var.app}-${var.env}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

#------------------------------------------------------------------------------
# Route table public
#------------------------------------------------------------------------------
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name        = "${var.app}-${var.env}-public-rt-${random_string.suffix.result}"
    Terraform   = true
    App         = var.app
    Environment = "${var.app}-${var.env}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

#------------------------------------------------------------------------------
# Route table private
#------------------------------------------------------------------------------
resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.app}-${var.env}-private-rt-${random_string.suffix.result}"
    Terraform   = true
    App         = var.app
    Environment = "${var.app}-${var.env}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

#------------------------------------------------------------------------------
# Route
#------------------------------------------------------------------------------
resource "aws_route" "route" {
  route_table_id         = aws_vpc.main.main_route_table_id
  destination_cidr_block = var.route_destination_cidr_block
  gateway_id             = aws_internet_gateway.gw.id
}
