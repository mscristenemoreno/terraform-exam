provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  name    = "${local.env_name}-vpc"
  version = "3.11.0"

  cidr = "20.0.0.0/16"

  azs            = ["${var.aws_region}a", "${var.aws_region}b"]
  public_subnets = ["20.0.1.0/24", "20.0.2.0/24"]

  public_subnet_tags = {
    Name = "dev-public-subnet"
  }

  create_igw = false

  tags = local.common_tags
}


