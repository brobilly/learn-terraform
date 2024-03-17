
resource "aws_security_group" "public_sg" {
  name        = "public_sg"
  description = "Allow http and ssh traffic"
  vpc_id      = aws_vpc.terra_vpc.id

  tags = {
    Name = "public_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.public_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.public_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_egress" {
  security_group_id = aws_security_group.public_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}


resource "aws_security_group" "lb_sg" {
  name        = "lb_sg"
  description = "SG for Load Balancer"
  vpc_id      = aws_vpc.terra_vpc.id

  tags = {
    Name = "loadBalance_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_all_ingress_lb" {
  security_group_id = aws_security_group.lb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}


resource "aws_vpc_security_group_egress_rule" "allow_all_egress_lb" {
  security_group_id = aws_security_group.lb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_security_group" "db_sg" {
  name        = "db_sg"
  description = "SG for Load Balancer"
  vpc_id      = aws_vpc.terra_vpc.id

  tags = {
    Name = "database_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_db_port" {
  security_group_id = aws_security_group.db_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 3306
  to_port           = 3306
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_egress_db" {
  security_group_id = aws_security_group.db_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
