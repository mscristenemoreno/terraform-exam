variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "network_address_space" {}
variable "instance_size" {}

variable "instance_count" {
  default = 1
}

variable "subnet_count" {
  default = 2
}

variable "cluster_name" {
  default = "eks-cluster"
}

variable "map_accounts" {
  description = "Additional AWS account numbers to add to the aws-auth configmap."
  type        = list(string)

  default = [
    "777777777777",
    "888888888888",
  ]
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      rolearn  = "arn:aws:iam::666666666666:role/role1"
      username = "role1"
      groups   = ["system:masters"]
    },
  ]
}
variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      userarn  = "arn:aws:iam::666666666666:user/user1"
      username = "user1"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::666666666666:user/user2"
      username = "user2"
      groups   = ["system:masters"]
    },
  ]
}

variable "common_tags" {
  default = {}
}

variable "environment_tag" {}
