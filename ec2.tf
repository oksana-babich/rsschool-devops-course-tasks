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

resource "aws_instance" "First_private_instance" {
  ami                    = data.aws_ami.latest_ami_ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet_1.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  key_name               = var.key_name

  tags = {
    Name = "Private instance 1"
  }
}

resource "aws_instance" "Second_private_instance" {
  ami                    = data.aws_ami.latest_ami_ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet_2.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  key_name               = var.key_name

  tags = {
    Name = "Private instance 2"
  }
}
