module "web-service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "web-service"
  description = "Security group"
  vpc_id      = "module.vpc.vpc.id"

  ingress_cidr_blocks      = ["10.0.0.0/24"]
  ingress_rules            = ["https-443-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8090
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "10.0.0.0/24"
    },
    {
      rule        = "postgresql-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}

resorce "web-service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "web-service"
  description = "Security group 80"
  vpc_id      = "module.vpc.vpc.id"

  ingress_cidr_blocks      = ["10.0.0.0/24"]
  ingress_rules            = ["http-80-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8090
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "10.0.0.0/24"
    },
    {
      rule        = "postgresql-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}
