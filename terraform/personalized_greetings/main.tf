# File: ./personalized_greetings/main.tf

terraform {
  backend "s3" {
    bucket         = "bernard-tf-test-state"
    key            = "personalized_greetings/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}

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
  
  # Place EC2 in the first public subnet
  subnet_id = element(module.vpc.public_subnet_ids, 0)
}



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