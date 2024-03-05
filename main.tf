provider "aws"{
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "${var.region}"

}
resource "aws_vpc" "terraform-vpc"{
    cidr_block = var.cidr_block
    enable_dns_hostnames = true
    enable_dns_support =  true
}

resource "aws_internet_gateway" "terraform-vpc"{
    vpc_id = aws_vpc.terraform-vpc.id
    tags = {
      Name = "terraform-vpc-ig"
    }
}
resource "aws_route_table" "public" {
  //count = length(var.public_subnet_cidr_block)
  vpc_id = aws_vpc.terraform-vpc.id
  tags = {
    Name = "terraform-vpc-rt-public"
  }
}
resource "aws_route" "public" {
    route_table_id = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform-vpc.id
  
}

resource "aws_route_table" "private" {
  //count = length(var.private_subnet_cidr_block)
  vpc_id = aws_vpc.terraform-vpc.id
  tags = {
    Name = "terraform-vpc-rt-private"
  }
}

resource "aws_route" "private" {
    route_table_id = aws_route_table.private.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform-vpc.id
  
}
resource "aws_subnet" "private" {
    count = length(var.private_subnet_cidr_block)
    vpc_id = aws_vpc.terraform-vpc.id
    cidr_block = var.private_subnet_cidr_block[count.index]
    availability_zone = var.availability_zones[count.index % length(var.availability_zones)]
    tags = {
      Name = "terraform-vpc-subnet-private"
    }
}
resource "aws_subnet" "public" {
    count = length(var.public_subnet_cidr_block)
    vpc_id = aws_vpc.terraform-vpc.id
    cidr_block = var.public_subnet_cidr_block[count.index]
    availability_zone = var.availability_zones[count.index]
    map_public_ip_on_launch = true
    tags = {
      Name = "terraform-vpc-subnet-public"
    }
  
}
resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr_block)

  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_vpc.terraform-vpc.default_route_table_id
}
resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidr_block)

  subnet_id = aws_subnet.private[count.index].id
  route_table_id = aws_vpc.terraform-vpc.default_route_table_id
  
}
