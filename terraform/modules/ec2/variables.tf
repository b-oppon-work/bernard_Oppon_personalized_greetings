# File: ./modules/ec2/variables.tf

variable "key_path" {
  description = "Path to save the private key"
  type        = string
}

variable "key_name" {
  description = "Name for the key pair"
  type        = string
}

variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
}

variable "instance_name" {
  description = "Name for the EC2 instance"
  type        = string
}

variable "default_tags" {
  description = "A map of default tags to assign to resources"
  type        = map(string)
}


