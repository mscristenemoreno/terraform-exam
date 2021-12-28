provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version    = "3.11.0"

  create_vpc = true

  name = "dev-vpc"
  cidr = "20.0.0.0/16"

  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  private_subnets = ["20.0.1.0/24", "20.0.2.0/24"]
  public_subnets  = ["20.0.10.0/24", "20.0.20.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = true

  public_subnet_tags = {
    Name = "dev-vpc-public-subnet"
  }

  private_subnet_tags = {
    Name = "dev-vpc-private-subnet"
  }

  tags = merge(var.default_tags)
}


