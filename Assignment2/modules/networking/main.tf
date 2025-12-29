provider "aws" {
  region = var.region
}

# Create VPC
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name        = "${var.env_prefix}-vpc"
    Environment = var.env_prefix
    ManagedBy   = "Terraform"
  }
}

# Create Subnet
resource "aws_subnet" "this" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone
  tags = {
    Name        = "${var.env_prefix}-subnet"
    Environment = var.env_prefix
    ManagedBy   = "Terraform"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name        = "${var.env_prefix}-igw"
    Environment = var.env_prefix
    ManagedBy   = "Terraform"
  }
}

# Create Route Table
resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Name        = "${var.env_prefix}-rt"
    Environment = var.env_prefix
    ManagedBy   = "Terraform"
  }
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "this" {
  subnet_id      = aws_subnet.this.id
  route_table_id = aws_route_table.this.id
}
