output "vpc_id" {
  value = aws_vpc.DevOps_course_vpc.id
}

output "public_subnet_1_AZ" {
  value = aws_subnet.public_subnet_1.availability_zone
}

output "public_subnet_2_AZ" {
  value = aws_subnet.public_subnet_2.availability_zone
}

output "private_subnet_1_AZ" {
  value = aws_subnet.private_subnet_1.availability_zone
}

output "private_subnet_2_AZ" {
  value = aws_subnet.private_subnet_2.availability_zone
}