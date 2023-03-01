resource "random_id" "alb_id" {
  byte_length = 4
  keepers = {
    phoenix_alb = "seed"
  }
}

resource "aws_lb" "lb" {
  name = substr(join(
    "-",
    [
      local.common.Product,
      local.common.Environment,
      var.tag_role,
      random_id.alb_id.dec //only [a-z-] allowed by aws 
    ],
  ), 0, 32) // aws cap for aws alb name
  internal           = var.alb_internal_enable
  load_balancer_type = var.alb_type
  security_groups    = var.alb_security_groups
  subnets            = var.alb_subnets


  access_logs {
    bucket  = var.alb_access_log_bucket
    prefix  = var.alb_access_log_prefix
    enabled = var.alb_access_log_enable
  }

  tags = merge(
    {
      "Name" = join(
        ".",
        [
          local.common.Product,
          var.tag_role,
          local.common.Environment,
          var.tag_description,
        ],
      )
      "Description" = var.tag_description
    },
    local.common_tags,
    var.alb_additional_tags,
  )
}
