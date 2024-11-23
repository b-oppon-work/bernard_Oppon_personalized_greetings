# File: ./modules/vpc/outputs.tf

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "ID of the created VPC"
}

output "public_subnet_ids" {
  value       = aws_subnet.public_subnets.*.id
  description = "IDs of the public subnets"
}

output "private_subnet_ids" {
  value       = aws_subnet.private_subnets.*.id
  description = "IDs of the private subnets"
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.main.id
  description = "ID of the Internet Gateway"
}
