terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

#Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
}

#Create VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "LAB-VPC"
  cidr = "10.0.0.0/16"

  azs             = ["eu-central-1a", "eu-central-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.0.0/24", "10.0.2.0/24"]

  single_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
