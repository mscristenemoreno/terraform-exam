module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  name    = "${local.env_name}-vpc"
  version = "3.11.0"

  cidr = "20.0.0.0/16"

  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  public_subnets  = ["20.0.1.0/24", "20.0.2.0/24"]
  private_subnets = ["20.0.10.0/24", "20.0.20.0/24"]

  #azs             = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  #public_subnets  = ["20.0.1.0/24", "20.0.2.0/24", "20.0.3.0/24"]
  #private_subnets = ["20.0.10.0/24", "20.0.20.0/24", "20.0.30.0/24"]

  public_subnet_tags = {
    Name = "dev-public-subnet"
  }

  create_igw = false

  tags = local.common_tags
}


