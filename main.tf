terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.32.1"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = var.default_tags
  }
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  assign_generated_ipv6_cidr_block = true 
  enable_dns_hostnames = true
  enable_dns_support = true 
  tags = {
    "Name" = "${var.default_tags.env}-VPC"
    
  }
}
#Public Subnet: 10.0.0.0/24 ensuring no subnets have the same address
resource "aws_subnet" "public" {
    count = var.public_subnet_count
    vpc_id = aws_vpc.main.id
    cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
    ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, count.index)
    map_public_ip_on_launch = true
    tags = {
        "Name" = "${var.default_tags.env}-Public-Subnet-${data.aws_availability_zones.availability_zone.names[count.index]}"
    }
    availability_zone = data.aws_availability_zones.availability_zone.names[count.index]
}
#Private Subnet: 10.0.0.0/24
resource "aws_subnet" "private" {
    count = 2
    vpc_id = aws_vpc.main.id
    cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + var.public_subnet_count)
    map_public_ip_on_launch = true
    tags = {
        "Name" = "${var.default_tags.env}-Private-Subnet-${data.aws_availability_zones.availability_zone.names[count.index]}"
    }
    availability_zone = data.aws_availability_zones.availability_zone.names[count.index]
}

#Public RT

#Private RT

#igw

#NAT