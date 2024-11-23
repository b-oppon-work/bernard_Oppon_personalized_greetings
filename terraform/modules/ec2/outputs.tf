# File: ./modules/ec2/outputs.tf

output "private_key_path" {
  value       = var.key_path
  description = "Path to the private key file for SSH access"
}

output "instance_public_ip" {
  value       = aws_instance.ec2_instance.public_ip
  description = "Public IP of the EC2 instance"
}

output "instance_id" {
  value       = aws_instance.ec2_instance.id
  description = "ID of the EC2 instance"
}
