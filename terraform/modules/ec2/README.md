# EC2 Module

This Terraform module provisions an EC2 instance in AWS. Key features include:

- Securely generates an ED25519 SSH key pair for accessing the instance.
- Creates a key pair in AWS.
- Configurable instance attributes such as AMI, instance type, and tags.

## Features

- Launches an EC2 instance in a specified subnet.
- Supports attaching an automatically generated SSH key pair.
- Provides outputs for instance attributes (e.g., public IP, instance ID).

## Inputs

| Name         | Description                                     | Type        | Default | Required |
|--------------|-------------------------------------------------|-------------|---------|----------|
| `key_path`   | Path to save the private key locally            | `string`    |         | yes      |
| `key_name`   | Name for the key pair in AWS                    | `string`    |         | yes      |
| `ami`        | AMI ID for the EC2 instance                    | `string`    |         | yes      |
| `instance_type` | Instance type for the EC2 instance           | `string`    |         | yes      |
| `instance_name` | Name for the EC2 instance                    | `string`    |         | yes      |
| `default_tags` | A map of default tags to assign to the instance| `map(string)`| `{}`   | no       |
| `subnet_id`  | Subnet ID where the EC2 instance will be launched| `string`    |         | yes      |

## Outputs

| Name                 | Description                                |
|----------------------|--------------------------------------------|
| `private_key_path`   | Path to the saved private key              |
| `instance_public_ip` | Public IP address of the EC2 instance      |
| `instance_id`        | ID of the EC2 instance                     |

## Example Usage

```hcl
module "ec2" {
  source         = "../modules/ec2"
  key_name       = "personalized-greetings-key"
  key_path       = "${path.root}/../personalized-greetings-key.pem"
  ami            = "ami-0866a3c8686eaeeba"
  instance_type  = "t2.micro"
  instance_name  = "Personalized-Greetings-EC2"
  default_tags = {
    Environment = "Dev"
    Project     = "Personalized-Greetings"
  }

  # Specify the subnet for the EC2 instance
  subnet_id = element(module.vpc.public_subnet_ids, 0)
}
