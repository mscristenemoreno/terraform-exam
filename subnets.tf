module "subnet" {
  source             = "clouddrove/subnet/aws"
  version            = "0.15.0"
  name               = "subnets"
  environment        = "dev"
  label_order        = ["name", "environment"]
  availability_zones = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  vpc_id             = module.vpc.vpc_id
  type               = "public"
  igw_id             = "igw-5ea15639"
  cidr_block         = module.vpc.vpc_cidr_block
}
