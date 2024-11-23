# File: ./modules/ec2/ec2.tf

# Generate an ED25519 SSH key pair
resource "tls_private_key" "private_key" {
  algorithm = "ED25519"
}

# Save the private key locally
resource "local_file" "private_key_download" {
  content  = tls_private_key.private_key.private_key_pem  # Corrected the attribute reference
  filename = var.key_path
}

# Create the key pair in AWS
resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.private_key.public_key_openssh
  tags       = var.default_tags
}

# Launch an EC2 instance
resource "aws_instance" "ec2_instance" {
  ami           = var.ami
  instance_type = var.instance_type

  key_name = aws_key_pair.generated_key.key_name

  # Use default VPC and subnet
  associate_public_ip_address = true

  tags = merge(var.default_tags, { Name = var.instance_name })
}
