variable "region" {}
variable "vpc_cidr" {}
variable "pub_sub" {}
variable "priv_sub" {}

resource "aws_vpc" "vpc_flugel" {
   cidr_block         = var.vpc_cidr
   instance_tenancy   = "default"
   enable_dns_support = "true"
}

resource "aws_internet_gateway" "IGW" {
    vpc_id =  aws_vpc.vpc_flugel.id
}

resource "aws_eip" "nateip" {
   vpc   = true
}

resource "aws_nat_gateway" "NGW" {
   allocation_id = aws_eip.nateip.id
   subnet_id = aws_subnet.pub_sub.id
}

resource "aws_subnet" "pub_sub" {
   vpc_id =  aws_vpc.vpc_flugel.id
   cidr_block = var.pub_sub
}

resource "aws_subnet" "priv_sub" {
   vpc_id =  aws_vpc.vpc_flugel.id
   cidr_block = var.priv_sub
}

resource "aws_route_table" "PubRT" {
    vpc_id =  aws_vpc.vpc_flugel.id
         route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
     }
}

resource "aws_route_table" "PrivRT" {
   vpc_id = aws_vpc.vpc_flugel.id
   route {
   cidr_block = "0.0.0.0/0"
   nat_gateway_id = aws_nat_gateway.NGW.id
   }
}

resource "aws_route_table_association" "PubRTassoc" {
    subnet_id = aws_subnet.pub_sub.id
    route_table_id = aws_route_table.PubRT.id
}

resource "aws_route_table_association" "PrivRTassoc" {
    subnet_id = aws_subnet.priv_sub.id
    route_table_id = aws_route_table.PrivRT.id
}


