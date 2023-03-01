#------------------------------------------------------------------------------
# General
#------------------------------------------------------------------------------
data "aws_availability_zones" "available" {}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

#------------------------------------------------------------------------------
# Subnets public
#------------------------------------------------------------------------------
resource "aws_subnet" "public" {
  count = var.is_public ? length(data.aws_availability_zones.available.names) : 0

  vpc_id            = var.subnet_vpc_id
  cidr_block        = "${var.vpc_block_part}.${10 + count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]


  #ToDo Check: CKV_AWS_130: "Ensure VPC subnets do not assign public IP by default"
  map_public_ip_on_launch = var.is_public ? true : false
  //  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.app}-${var.env}-public-subnet-${random_string.suffix.result}"
    Terraform   = true
    App         = var.app
    Environment = "${var.app}-${var.env}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

#------------------------------------------------------------------------------
# Subnets public
#------------------------------------------------------------------------------
resource "aws_subnet" "private" {
  count = var.is_public ? 0 : length(data.aws_availability_zones.available.names)

  vpc_id                  = var.subnet_vpc_id
  cidr_block              = "${var.vpc_block_part}.${20 + count.index}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = var.is_public ? true : false

  tags = {
    Name        = "${var.app}-${var.env}-private-subnet-${random_string.suffix.result}"
    Terraform   = true
    App         = var.app
    Environment = "${var.app}-${var.env}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
