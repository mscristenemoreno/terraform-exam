variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {
  default = "ap-southeast-1"
}

variable "network_address_space" {
  default = "20.0.0.0/16"
}

variable "instance_size" {
  default = "t2.micro"
}

variable "instance_count" {
  default = 1
}

variable "subnet_count" {
  default = 2
}

variable "common_tags" {
  default = {}
}

variable "environment_tag" {}
