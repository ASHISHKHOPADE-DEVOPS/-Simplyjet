resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "MainVPC"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnets_cidrs[count.index]
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet ${count.index}"
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnets_cidrs[count.index]
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "Private Subnet ${count.index}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.public[0].id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}

resource "aws_route_table_association" "public_association" {
  count = length(aws_subnet.public)
  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_association" {
  count = length(aws_subnet.private)
  subnet_id = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}