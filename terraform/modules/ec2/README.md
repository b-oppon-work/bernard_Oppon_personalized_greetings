# EC2 Module

This Terraform module creates an EC2 instance in the default VPC, along with an ED25519 key pair for SSH access.

## Input Variables

- `key_path` (string): Path to save the private key.
- `key_name` (string): Name for the key pair.
- `ami` (string): AMI ID for the EC2 instance.
- `instance_type` (string): Instance type for the EC2 instance.
- `instance_name` (string): Name for the EC2 instance.
- `default_tags` (map): Default tags to apply to resources.
- `region` (string): AWS region to deploy the resources.

## Outputs

- `private_key_path`: Path to the private key file for SSH access.
- `instance_public_ip`: Public IP address of the EC2 instance.
- `instance_id`: ID of the EC2 instance.
