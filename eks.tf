module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_version                 = "1.21"
  cluster_name                    = var.cluster_name
  vpc_id                          = module.vpc.vpc_id
  subnets                         = module.vpc.private_subnets
  cluster_create_timeout          = "1h"
  cluster_endpoint_private_access = true

  worker_groups = [
    {
      name                          = "worker-group"
      instance_type                 = var.instance_size
      asg_desired_capacity          = 1
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
    }
  ]
  worker_additional_security_group_ids = [aws_security_group.all_worker_mgmt.id]
  map_roles                            = var.map_roles
  map_users                            = var.map_users
  map_accounts                         = var.map_accounts

  tags = merge(local.common_tags, { Name = "${var.environment_tag}-eks-cluster" })
}

