resource "aws_network_acl" "public_nacl" {
  vpc_id = aws_vpc.DevOps_course_vpc.id
  tags = {
    Name = "Public NACL"
  }
}

resource "aws_network_acl_rule" "public_in_ssh" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number    = 100
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "public_in_http" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number    = 110
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "public_in_icmp" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number    = 120
  egress         = false
  protocol       = "1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  icmp_type      = -1
  icmp_code      = -1
}

resource "aws_network_acl_rule" "public_in_https" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number    = 130
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "public_in_ephemeral" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number    = 140
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block    = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "public_out_all" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number    = 100
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_association" "assoc_public_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  network_acl_id = aws_network_acl.public_nacl.id
}

resource "aws_network_acl_association" "assoc_public_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  network_acl_id = aws_network_acl.public_nacl.id
}

resource "aws_network_acl" "private_nacl" {
  vpc_id = aws_vpc.DevOps_course_vpc.id
  tags = {
    Name = "PrivateNACL"
  }
}

resource "aws_network_acl_rule" "private_in_ssh" {
  network_acl_id = aws_network_acl.private_nacl.id
  rule_number    = 100
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "10.0.0.0/16"
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "private_in_icmp" {
  network_acl_id = aws_network_acl.private_nacl.id
  rule_number    = 110
  egress         = false
  protocol       = "1"
  rule_action    = "allow"
  cidr_block     = "10.0.0.0/16"
  icmp_type      = -1
  icmp_code      = -1
}

resource "aws_network_acl_rule" "private_in_ephemeral" {
  network_acl_id = aws_network_acl.private_nacl.id
  rule_number    = 120
  egress         = false
  protocol       = "6" # TCP
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "private_in_ephemeral_udp" {
  network_acl_id = aws_network_acl.private_nacl.id
  rule_number    = 130
  egress         = false
  protocol       = "17" # UDP
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "private_out_all" {
  network_acl_id = aws_network_acl.private_nacl.id
  rule_number    = 100
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_association" "assoc_private_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  network_acl_id = aws_network_acl.private_nacl.id
}

resource "aws_network_acl_association" "assoc_private_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  network_acl_id = aws_network_acl.private_nacl.id
}