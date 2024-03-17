resource "aws_vpc" "terra_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    name = "terra"
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id                  = aws_vpc.terra_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-1a"
  map_public_ip_on_launch = true
  tags = {
    name = "sub_public"
  }
}

resource "aws_subnet" "subnet_c" {
  vpc_id                  = aws_vpc.terra_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-west-1c"
  map_public_ip_on_launch = true
  tags = {
    name = "sub_public2"
  }
}

resource "aws_subnet" "subnet_pvt_a" {
  vpc_id                  = aws_vpc.terra_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-west-1a"
  map_public_ip_on_launch = false
  tags = {
    name = "sub_private"
  }
}

resource "aws_subnet" "subnet_pvt_c" {
  vpc_id                  = aws_vpc.terra_vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-west-1c"
  map_public_ip_on_launch = false
  tags = {
    name = "sub_private2"
  }
}

resource "aws_internet_gateway" "terra_igw" {
  vpc_id = aws_vpc.terra_vpc.id

  tags = {
    Name = "terra_igw"
  }
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.terra_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terra_igw.id
  }
}

resource "aws_route_table_association" "pub_subnet_a_rta" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "pub_subnet_c_rta" {
  subnet_id      = aws_subnet.subnet_c.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_db_subnet_group" "db_subnet" {
  name       = "db_subnet"
  subnet_ids = [aws_subnet.subnet_pvt_a.id, aws_subnet.subnet_pvt_c.id]
}

