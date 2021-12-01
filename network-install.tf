module "vpc-1" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.0.0/24"]

  enable_nat_gateway = true


  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

module "vpc-2" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1b"]
  private_subnets = ["10.0.3.0/24"]
  public_subnets  = ["10.0.2.0/24"]


  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
