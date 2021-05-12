# VPC
resource "aws_vpc" "mwaa_default_vpc" {
  cidr_block       = "${var.vpc_cidr_block}"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Group = "mwaa_env"
  }
}

resource "aws_internet_gateway" "mwaa_igw" {
  vpc_id = aws_vpc.mwaa_default_vpc.id

  depends_on = [aws_vpc.mwaa_default_vpc]

  tags = {
    Group = "mwaa_env"
  }
}

# Public Subnet 1
resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.mwaa_default_vpc.id
  cidr_block = "10.192.10.0/24"
  map_public_ip_on_launch = true
  availability_zone = "${var.aws_region}a"

  depends_on = [
    aws_internet_gateway.mwaa_igw
  ]

  tags = {
    Group = "mwaa_env"
  }
}

# Public Subnet 2
resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.mwaa_default_vpc.id
  cidr_block = "10.192.11.0/24"
  map_public_ip_on_launch = true
  availability_zone = "${var.aws_region}b"

  depends_on = [
    aws_internet_gateway.mwaa_igw
  ]

  tags = {
    Group = "mwaa_env"
  }
}

# Private Subnet 1
resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.mwaa_default_vpc.id
  cidr_block = "10.192.20.0/24"
  map_public_ip_on_launch = false
  availability_zone = "${var.aws_region}a"

  depends_on = [
    aws_internet_gateway.mwaa_igw
  ]

  tags = {
    Group = "mwaa_env"
  }
}

# Private Subnet 2
resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.mwaa_default_vpc.id
  cidr_block = "10.192.21.0/24"
  map_public_ip_on_launch = false
  availability_zone = "${var.aws_region}b"

  depends_on = [
    aws_internet_gateway.mwaa_igw
  ]

  tags = {
    Group = "mwaa_env"
  }
}

# NAT Gateway EIP 1
resource "aws_eip" "nat_gateway_1_eip" {
  vpc = true

  depends_on = [
    aws_internet_gateway.mwaa_igw
  ]

  tags = {
    Group = "mwaa_env"
  }
}

# NAT Gateway EIP 2
resource "aws_eip" "nat_gateway_2_eip" {
  vpc = true

  depends_on = [
    aws_internet_gateway.mwaa_igw
  ]

  tags = {
    Group = "mwaa_env"
  }
}

# NAT Gateway 1
resource "aws_nat_gateway" "nat_gateway_1" {
  allocation_id = aws_eip.nat_gateway_1_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  depends_on = [
    aws_internet_gateway.mwaa_igw
  ]

  tags = {
    Group = "mwaa_env"
  }
}

# NAT Gateway 2
resource "aws_nat_gateway" "nat_gateway_2" {
  allocation_id = aws_eip.nat_gateway_2_eip.id
  subnet_id     = aws_subnet.public_subnet_2.id

  depends_on = [
    aws_internet_gateway.mwaa_igw
  ]

  tags = {
    Group = "mwaa_env"
  }
}

# Public Route Table & Route
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.mwaa_default_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mwaa_igw.id
  }

  tags = {
    Group = "mwaa_env"
  }
}

# Public Subnet 1 Route Table Association
resource "aws_route_table_association" "public_route_table_assn_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

# Public Subnet 2 Route Table Association
resource "aws_route_table_association" "public_route_table_assn_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

# Private Route Table & Route 1
resource "aws_route_table" "private_route_table_1" {
  vpc_id = aws_vpc.mwaa_default_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_1.id
  }

  tags = {
    Group = "mwaa_env"
  }
}

# Private Subnet 1 Route Table Association
resource "aws_route_table_association" "private_route_table_assn_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table_1.id
}

# Private Route Table & Route 2
resource "aws_route_table" "private_route_table_2" {
  vpc_id = aws_vpc.mwaa_default_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_2.id
  }

  tags = {
    Group = "mwaa_env"
  }
}

# Private Subnet 2 Route Table Association
resource "aws_route_table_association" "private_route_table_assn_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table_2.id
}

resource "aws_security_group" "main_sg" {
  name        = "no_ingress_sg"
  description = "Security group with no ingress rule"
  vpc_id      = aws_vpc.mwaa_default_vpc.id

  ingress {
    description      = "Allow all inbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"

    # VERY IMPORTANT
    self             = true
  }

  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Group = "mwaa_env"
  }
}

