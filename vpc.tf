resource "aws_vpc" "DevOps_course_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "VPC for DevOps-Course"
  }
}

resource "aws_internet_gateway" "course_igw" {
  vpc_id = aws_vpc.DevOps_course_vpc.id

  tags = {
    Name = "IGW for DevOps-Course"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.DevOps_course_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet 1 for DevOps-Course in AZ1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.DevOps_course_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet 2 for DevOps-Course in AZ2"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.DevOps_course_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "Private Subnet 1 for DevOps-Course in AZ1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.DevOps_course_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "Private Subnet 2 for DevOps-Course in AZ2"
  }
}