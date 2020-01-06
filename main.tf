# Specify the provider and access details
provider "aws" {
  region = var.aws_region
}

# Create a VPC to launch our instances into
resource "aws_vpc" "dev" {
  cidr_block = var.aws_subnet["dev_main"]
  enable_dns_hostnames = true
  enable_dns_support = true
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "dev" {
  vpc_id = aws_vpc.dev.id
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.dev.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.dev.id
}

# Create a subnet to launch our instances into
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = var.aws_subnet["dev_public"]
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_a" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = var.aws_subnet["dev_a"]
  map_public_ip_on_launch = false
  availability_zone       = var.aws_az["dev_a"]
}

# SSH key
resource "aws_key_pair" "auth" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

# Remote state file
resource "aws_s3_bucket" "dd_state" {
  bucket = "dd-state"
  versioning {
    enabled = true
  }
  lifecycle {
    prevent_destroy = true
  }
}

#terraform {
#  required_version = ">= 0.9"
#  backend "s3" {
#    bucket = "dd-state"
#    key    = "main/terraform.state"
#    region = "us-west-2"
#  }
#}
