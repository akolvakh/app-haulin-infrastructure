resource "aws_instance" "openvpn" {
  ami                    = local.images[var.server_region]
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  subnet_id              = var.public_subnet_ids //"${element(split(",", var.public_subnet_ids), count.index)}"
  key_name               = aws_key_pair.ec2.key_name



  user_data = <<-EOF
              admin_user=${var.server_username}
              admin_pw=${var.server_password}
              EOF

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = tls_private_key.ec2.private_key_pem
    host        = self.public_ip
  }
  
  tags = {
    Name = "openvpn"
  }
}

resource "aws_security_group" "instance" {
  name        = "openvpn-default"
  description = "OpenVPN security group"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 943
    to_port     = 943
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 945
    to_port     = 945
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 1194
    to_port     = 1194
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "tls_private_key" "ec2" {
  algorithm   = "RSA"
}

resource "aws_key_pair" "ec2" {
  key_name   = "openvpn-key" //"${var.instance_name}-${var.env}-key"
  public_key = tls_private_key.ec2.public_key_openssh
}

resource "local_file" "ec2" {
    content = tls_private_key.ec2.private_key_pem
    filename = "keys/${aws_key_pair.ec2.key_name}.pem"
}