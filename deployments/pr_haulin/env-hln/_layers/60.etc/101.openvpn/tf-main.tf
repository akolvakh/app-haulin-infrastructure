//data "aws_ami" "ubuntu" {
//  most_recent = true
//
//  filter {
//    name   = "name"
//    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
//    values = ["paravirtual"]
//  }
//
//  owners = ["099720109477"]
//}

resource "aws_security_group" "openvpn" {
  name        = "${var.name}"
  vpc_id      = "${var.vpc_id}"
  description = "OpenVPN security group"

  # tags {
  #   Name = "${var.name}"
  # }

  ingress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  # For OpenVPN Client Web Server & Admin Web UI
  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "udp"
    from_port   = 1194
    to_port     = 1194
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ebs_volume" "openvpn_data" {
  availability_zone = "${var.ebs_region}"
  size              = "${var.ebs_size}"
  encrypted         = true

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_instance" "openvpn" {
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name      = aws_key_pair.ec2.key_name
  subnet_id     = var.public_subnet_ids //"${element(split(",", var.public_subnet_ids), count.index)}"

  vpc_security_group_ids = ["${aws_security_group.openvpn.id}"]

  # tags {
  #   Name = "${var.name}"
  # }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  instance_id = "${aws_instance.openvpn.id}"
  volume_id   = "${aws_ebs_volume.openvpn_data.id}"

  provisioner "local-exec" {
  yum install ansible -y
    command = "ansible-playbook --private-key ~/.ssh/id_rsa.pub -i '${aws_instance.openvpn.public_ip},' config/ansible/openvpn.yml"
  }
}

resource "aws_route53_record" "openvpn" {
  zone_id = "${var.route_zone_id}"
  name    = "vpn.${var.domain}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.openvpn.public_ip}"]
}


resource "tls_private_key" "ec2" {
  algorithm   = "RSA"
}

resource "aws_key_pair" "ec2" {
  key_name   = "${var.key_name}-key"
  public_key = tls_private_key.ec2.public_key_openssh
}

resource "local_file" "ec2" {
    content = tls_private_key.ec2.private_key_pem
    filename = "keys/${aws_key_pair.ec2.key_name}.pem"
}