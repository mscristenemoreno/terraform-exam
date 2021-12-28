variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "aws_region" {
  default = "ap-southeast-1"
}

variable "environment_tag" {}

variable "common_tags" {
  default = {}
}
variable "network_address_space" {
  default = "20.0.0.0/16"
}

variable "instance_count" {
  default = 1
}

variable "subnet_count" {
  default = 2
}
