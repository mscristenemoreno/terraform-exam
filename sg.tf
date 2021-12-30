module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "sg-${var.environment_tag}"
  description = "Security group"
  vpc_id      = module.vpc.vpc_id

  # SG for ALB
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "all-icmp"]
  egress_rules        = ["all-all"]

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]

  tags = local.tags
}
