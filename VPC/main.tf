resource "aws_vpc" "vpc" {
cidr_block = var.cidr
enable_dns_hostnames = true
enable_dns_support = true
tags = {
  Name = var.vpc_name
}
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = var.IGW_NAME
  }
}

resource "aws_subnet" "public01" {
cidr_block = var.IPV4_PUB01
vpc_id = aws_vpc.vpc.id
availability_zone = "us-east-1a"
map_public_ip_on_launch = true
tags = {
  Name = var.pub-subnet-name
}
}

resource "aws_subnet" "private01" {
cidr_block = var.IPV4_Pvt01
vpc_id = aws_vpc.vpc.id
availability_zone = "us-east-1a"
map_public_ip_on_launch = false
tags = {
  Name = var.pvt-subnet-name
}
}

resource "aws_eip" "nat_EIP" {
domain = "vpc"
tags = {
  Name = "Nat_EIP"
}
}


resource "aws_nat_gateway" "NATGW" {
  subnet_id=aws_subnet.public01.id
  allocation_id = aws_eip.nat_EIP.id
  depends_on = [ aws_internet_gateway.IGW , aws_eip.nat_EIP ]
  tags = {
    Name = var.NATgw
  }
}

resource "aws_route_table" "Public-rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = var.Public-rt-name
  }
}

resource "aws_route" "public_route" {
route_table_id = aws_route_table.Public-rt.id
gateway_id = aws_internet_gateway.IGW.id
destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "pub_association" {
    subnet_id = aws_subnet.public01.id
    route_table_id = aws_route_table.Public-rt.id
}


resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name=var.private-rt-name
  }
}

resource "aws_route" "private-route" {
  route_table_id = aws_route_table.private-rt.id
  nat_gateway_id = aws_nat_gateway.NATGW.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "pvt-association" {
    subnet_id = aws_subnet.private01.id
    route_table_id = aws_route_table.private-rt.id
}

