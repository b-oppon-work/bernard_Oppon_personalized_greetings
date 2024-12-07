# File: ./modules/vpc/vpc.tf

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  tags       = merge(var.default_tags, { Name = var.vpc_name })
}

# Create Public Subnets
resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true

  tags = merge(var.default_tags, { Name = "Public-Subnet-${count.index + 1}" })
}

# Create Private Subnets
resource "aws_subnet" "private_subnets" {
  count      = length(var.private_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidrs[count.index]

  tags = merge(var.default_tags, { Name = "Private-Subnet-${count.index + 1}" })
}

# Create an Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags   = merge(var.default_tags, { Name = "Main-Internet-Gateway" })
}

# Create a Route Table for Public Subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(var.default_tags, { Name = "Public-Route-Table" })
}

# Associate Public Route Table with Public Subnets
resource "aws_route_table_association" "public_associations" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public.id
}

# Create a Route Table for Private Subnets (optional)
# Explanation: Private subnets don't need explicit internet routes in many cases.
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.default_tags, { Name = "Private-Route-Table" })
}

# Associate Private Route Table with Private Subnets
resource "aws_route_table_association" "private_associations" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private.id
}
