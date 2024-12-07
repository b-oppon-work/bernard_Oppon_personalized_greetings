# VPC Module

This Terraform module creates a custom Virtual Private Cloud (VPC) infrastructure in AWS, including:

- A VPC with a specified CIDR block.
- Public and private subnets.
- An Internet Gateway for public subnet connectivity.
- Route tables for public and private subnets.

## Features

- Dynamically creates subnets based on provided CIDR blocks.
- Associates public subnets with a route table for Internet Gateway access.
- Provides outputs for integrating with other modules, such as EC2.

## Inputs

| Name                  | Description                                     | Type        | Default | Required |
|-----------------------|-------------------------------------------------|-------------|---------|----------|
| `cidr_block`          | CIDR block for the VPC                         | `string`    |         | yes      |
| `vpc_name`            | Name for the VPC                               | `string`    |         | yes      |
| `public_subnet_cidrs` | List of CIDR blocks for public subnets          | `list`      |         | yes      |
| `private_subnet_cidrs`| List of CIDR blocks for private subnets         | `list`      |         | yes      |
| `default_tags`        | A map of default tags to assign to all resources| `map(string)`| `{}`   | no       |

## Outputs

| Name                   | Description                                |
|------------------------|--------------------------------------------|
| `vpc_id`               | ID of the created VPC                     |
| `public_subnet_ids`    | IDs of the created public subnets          |
| `private_subnet_ids`   | IDs of the created private subnets         |
| `internet_gateway_id`  | ID of the created Internet Gateway         |

## Example Usage

```hcl
module "vpc" {
  source               = "../modules/vpc"
  cidr_block           = "10.0.0.0/16"
  vpc_name             = "Personalized-Greetings-VPC"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  default_tags = {
    Environment = "Dev"
    Project     = "Personalized-Greetings"
  }
}
