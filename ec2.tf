data "aws_ami" "latest_ami_ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Ubuntu (canonical)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.latest_ami_ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet_1.id
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = {
    Name = "Bastion Host"
  }
}

resource "aws_instance" "Second_public_instance" {
  ami                         = data.aws_ami.latest_ami_ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet_2.id
  vpc_security_group_ids      = [aws_security_group.public_restricted_sg.id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  tags = {
    Name = "Public instance 2"
  }
}


locals {
  control_plane_ip = aws_instance.k3s_control_plane.private_ip
}

resource "aws_instance" "k3s_control_plane" {
  ami                    = data.aws_ami.latest_ami_ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet_1.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  key_name               = var.key_name


  user_data = <<-EOF
              #!/bin/bash
              curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC='server' K3S_TOKEN=${var.k3s_token} K3S_KUBECONFIG_MODE='644' sh -s -
              EOF
tags = {
    Name = "k3s Control Plane"
  }
}

resource "aws_instance" "k3s_worker_node" {
  depends_on = [aws_instance.k3s_control_plane]
  ami                    = data.aws_ami.latest_ami_ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet_2.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  key_name               = var.key_name
  user_data = <<-EOF
              #!/bin/bash
              K3S_URL="https://${aws_instance.k3s_control_plane.private_ip}:6443"
              curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent --server $K3S_URL --token ${var.k3s_token}" sh -s -
              EOF
  tags = {
    Name = "k3S Worker Node"
  }
}
