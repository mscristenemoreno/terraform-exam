module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  name    = "${local.env_name}-vpc"
  version = "3.11.0"

  cidr = var.network_address_space

  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  private_subnets = ["20.0.1.0/24", "20.0.2.0/24"]
  public_subnets  = ["20.0.10.0/24", "20.0.20.0/24"]

  #azs             = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  #private_subnets  = ["20.0.1.0/24", "20.0.2.0/24", "20.0.3.0/24"]
  #public_subnets = ["20.0.10.0/24", "20.0.20.0/24", "20.0.30.0/24"]

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
  }

  create_igw           = false
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = local.tags
}


