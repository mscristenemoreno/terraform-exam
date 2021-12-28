variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "aws_region" {
  default = "ap-southeast-1"
}

variable "default_tags" {
  description = "Tags set for modules"
  type        = map(string)
  default = {
    project     = "terraform-exam"
    environment = "dev"
  }
}
