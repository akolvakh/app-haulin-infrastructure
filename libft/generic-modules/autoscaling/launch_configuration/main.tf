#------------------------------------------------------------------------------
# Launch configuration
#------------------------------------------------------------------------------
resource "aws_launch_configuration" "this" {
  count = var.count_size

  name_prefix                 = var.name
  image_id                    = var.image_id
  instance_type               = var.instance_type
  iam_instance_profile        = var.iam_instance_profile
  key_name                    = var.key_name
  security_groups             = [var.security_groups]
  associate_public_ip_address = var.associate_public_ip_address
  user_data                   = var.user_data
  enable_monitoring           = var.enable_monitoring
  placement_tenancy           = var.placement_tenancy
  ebs_optimized               = var.ebs_optimized

  #ToDo Check: CKV_AWS_8: "Ensure all data stored in the Launch configuration EBS is securely encrypted"
  ebs_block_device       = var.ebs_block_device
  ephemeral_block_device = var.ephemeral_block_device
  root_block_device      = var.root_block_device

  #ToDo Check: CKV_AWS_8: "Ensure all data stored in the Launch configuration EBS is securely encrypted"
  root_block_device {
    //    encrypted = var.root_block_device_encrypted
    encrypted = true
  }

  lifecycle {
    create_before_destroy = var.create_before_destroy
  }

  # spot_price                  = var.spot_price  // placement_tenancy does not work with spot_price
}
