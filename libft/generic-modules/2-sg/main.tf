#Why have this module at all, when it is just tiny wrapper on top of TF aws_security_group resource?
# Only value is  consistent naming and tagging

resource "aws_security_group" "sg" {
  name = join(
    ".",
    [
      local.common.Product,
      local.common.Environment,
      var.tag_role,
      "sg",
    ],
  )
  description = var.tag_description
  vpc_id      = var.vpc_id

  ingress = var.ingress
  egress  = var.egress
  tags = merge(
    {
      "Name" = join(
        ".",
        [
          local.common.Product,
          local.common.Environment,
          var.tag_role,
          "sg",
        ],
      )
      "Description" = var.tag_description
    },
    local.common_tags,
    var.sg_additional_tags,
  )
}
