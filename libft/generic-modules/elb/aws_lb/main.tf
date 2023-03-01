#------------------------------------------------------------------------------
# General
#------------------------------------------------------------------------------
resource "random_string" "suffix" {
  length  = 8
  special = false
}

#------------------------------------------------------------------------------
# Application Load Balancer
#------------------------------------------------------------------------------
resource "aws_alb" "main" {
  name                       = var.elb_name
  security_groups            = var.elb_security_groups
  subnets                    = var.subnet_ids
  load_balancer_type         = var.elb_load_balancer_type
  internal                   = var.elb_internal
  enable_deletion_protection = var.elb_enable_deletion_protection

  #ToDo Check: CKV_AWS_131: "Ensure that ALB drops HTTP headers"
  drop_invalid_header_fields = true

  access_logs {
    bucket  = var.access_logs_bucket
    prefix  = var.access_logs_prefix
    enabled = var.access_logs_enabled
  }

  tags = {
    Name        = "${var.app}-${var.env}-elb-${random_string.suffix.result}-"
    Terraform   = true
    App         = var.app
    Environment = "${var.app}-${var.env}"
  }
}
