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
}
