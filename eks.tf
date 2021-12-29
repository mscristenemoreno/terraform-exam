



module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_version = "1.21"
  cluster_name    = "${var.environment_tag}-cluster"
  vpc_id          = module.vpc.vpc_id
  subnets         = [module.vpc.private_subnets[0], module.vpc.public_subnets[1]]

  worker_groups = [
    {
      name                 = "worker-group"
      instance_type        = var.instance_size
      asg_desired_capacity = 2
    },
  ]
}