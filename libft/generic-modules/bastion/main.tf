#data "aws_ami" "ubuntu" {
#  most_recent = true
#
#  filter {
#    name   = "name"
#    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-*"]
#  }
#
#  filter {
#    name   = "virtualization-type"
#    values = ["hvm"]
#  }
#
#  owners = ["099720109477"] # Canonical
#}

resource "aws_instance" "default" {

 # ami                    = var.ami == "default" ? data.aws_ami.ubuntu.id : var.ami
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.ec2.key_name
  # subnet_id              = var.subnet_ids[*].id
  subnet_id              = var.subnet_ids
#  security_groups        = [ var.security_group_id ]
  vpc_security_group_ids = [ var.security_group_id ]
  
  user_data = <<-EOL
  #!/bin/bash -xe

  sudo apt install snapd
  sudo snap install liquibase
  wget https://jdbc.postgresql.org/download/postgresql-42.3.2.jar
  sudo apt-get install rsync
  EOL
  
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = tls_private_key.ec2.private_key_pem
    host        = self.public_ip
  }

  tags = {
    Name = var.instance_name
  }
  lifecycle {
    prevent_destroy = false
    ignore_changes = [ami]
  }
}

resource "aws_eip" "default" {
  vpc      = true
  instance = aws_instance.default.id
  #TODO prevent destroy for env module each run
  # lifecycle {
  #   prevent_destroy = true
  # }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.default.id
  allocation_id = aws_eip.default.id
}

resource "tls_private_key" "ec2" {
  algorithm   = "RSA"
}

resource "aws_key_pair" "ec2" {
  key_name   = "${var.instance_name}-${var.env}-key"
  public_key = tls_private_key.ec2.public_key_openssh
}

resource "local_file" "ec2" {
    content = tls_private_key.ec2.private_key_pem
    filename = "keys/${aws_key_pair.ec2.key_name}.pem"
}