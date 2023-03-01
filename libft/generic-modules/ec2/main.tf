#------------------------------------------------------------------------------
# AMI
#------------------------------------------------------------------------------
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  # AMI Supporting SSM
  filter {
    name = "name"
    # e.g.: amzn2-ami-hvm-2.0.20210219.0-x86_64-gp2
    values = ["amzn2-ami-hvm-2.0.????????.??-x86_64-gp2"]
  }
}

#------------------------------------------------------------------------------
# Instance
#------------------------------------------------------------------------------
resource "aws_instance" "instance" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  associate_public_ip_address = false

  # TODO: This setup should be a module for per account SSM instance profile setup
  # TODO: make this an optional variable
  iam_instance_profile = "AmazonSSMRoleForInstancesQuickSetup"

  vpc_security_group_ids = [var.security_group_id]

  subnet_id  = var.subnet_id
  private_ip = var.private_ip


  # Checkov reccomendations
  # ToDo Check: CKV_AWS_126: "Ensure that detailed monitoring is enabled for EC2 instances"
  # monitoring = true

  # ToDo Check: CKV_AWS_135: "Ensure that EC2 is EBS optimized"
  # ebs_optimized = true

  # ToDo Check: CKV_AWS_8: "Ensure all data stored in the Launch configuration EBS is securely encrypted"
  # ebs_block_device {
  #   device_name = "phoenix-ebs-block"
  #   encrypted   = true
  # }

  # ToDo Check: CKV_AWS_79: "Ensure Instance Metadata Service Version 1 is not enabled"
  # metadata_options {
  #   http_tokens = "required"
  # }

  # ToDo Check: CKV_AWS_8: "Ensure all data stored in the Launch configuration EBS is securely encrypted"
  # root_block_device {
  #   encrypted = true
  # }

  tags = {
    Name = var.instance_name
  }
}