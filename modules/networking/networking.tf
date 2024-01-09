resource "aws_internet_gateway" "test-igw" {
  vpc_id = aws_vpc.test-vpc.id

  tags = {
    Name = "main"
  }
}


resource "aws_subnet" "test_priavte_subnet" {
  vpc_id     = aws_vpc.test-vpc.id
  cidr_block = var.private_subnet_cidr

  availability_zone = var.az_private_subnet
}


resource "aws_subnet" "test_public_subnet" {
  vpc_id     = aws_vpc.test-vpc.id
  cidr_block = var.public_subnet_cidr

  availability_zone       = var.az
  map_public_ip_on_launch = true
}




resource "aws_route_table" "test-rt" {
  vpc_id = aws_vpc.test-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test-igw.id
  }

  tags = {
    Name = "example"
  }
}

resource "aws_route_table_association" "test-rt-assoc" {
  subnet_id      = aws_subnet.test_public_subnet.id
  route_table_id = aws_route_table.test-rt.id
}

resource "aws_vpc" "test-vpc" {
  cidr_block = var.cidr_block

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    enviroment = "${var.enviroment}"
  }
}


resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "allow_all"
  vpc_id      = aws_vpc.test-vpc.id

  ingress {
    description = "allow_all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}


