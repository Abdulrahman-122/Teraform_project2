resource "aws_vpc" "main_vpc" {
    cidr_block = var.vpc_main
    enable_dns_hostnames=true
    enable_dns_support = true
    tags={
        Name="gym-vpc"
    }
}
resource "aws_internet_gateway" "gw"{
    vpc_id=aws_vpc.main_vpc.id

}
# as we know we have 3 azs on this region from a ,b,c
resource "aws_subnet" "public1"{
    vpc_id=aws_vpc.main_vpc.id
    cidr_block = var.public_subnet1_cidr
    availability_zone= "${var.region}a"
    # assign public ip in this subnet once instance launched.
    map_public_ip_on_launch=true
    tags={
        Name="Public subnet1"
    }

}
resource "aws_subnet" "public2"{
    vpc_id=aws_vpc.main_vpc.id
    cidr_block = var.public_subnet2_cidr
    availability_zone = "${var.region}b"
    map_public_ip_on_launch=true
    tags={
        Name="Public subnet2"
    }
}
resource "aws_subnet" "private1"{
    vpc_id=aws_vpc.main_vpc.id
    cidr_block = var.private_subnet1_cidr
    availability_zone = "${var.region}a"
    map_public_ip_on_launch = false
    tags = {
      Name="Private subnet1"
    }
}
resource "aws_subnet" "private2" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = var.private_subnet2_cidr
    availability_zone = "${var.region}b"
    map_public_ip_on_launch = false
    tags = {
      Name="Private subnet2"
    }
}

# build  a route table in order to routes the ips toward the system (subnets)
resource "aws_route_table" "public"{
    vpc_id=aws_vpc.main_vpc.id
}
resource "aws_route" "internet"{
    route_table_id = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
}
resource "aws_route_table_association" "public1"{
    subnet_id = aws_subnet.public1.id
    route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public2"{
    subnet_id=aws_subnet.public2.id
    route_table_id=aws_route_table.public.id
}

resource "aws_eip" "nat" {
    domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat.id
    subnet_id = aws_subnet.public1.id
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main_vpc.id
    tags = {
      Name="gym-private-route-table"
    }

}

resource "aws_route" "private_internet" {
    route_table_id = aws_route_table.private.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
}
resource "aws_route_table_association" "private1" {
    subnet_id = aws_subnet.private1.id
    route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private2" {
    subnet_id = aws_subnet.private2.id
    route_table_id = aws_route_table.private.id
  
}