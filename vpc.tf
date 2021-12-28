provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "vpc" {
  source     = "terraform-aws-modules/vpc/aws"
  create_vpc = false

  name = "dev-vpc"
  cidr = "172.31.0.0/16"

  manage_default_vpc               = true
  default_vpc_name                 = "default-vpc"
  default_vpc_enable_dns_hostnames = true

  tags = merge(var.default_tags)
}


