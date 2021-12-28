resource "aws_internet_gateway" "gw" {
  vpc_id = module.vpc.vpc_id

  tags = {
    Name = "dev-vpc-igw"
  }
}

resource "aws_security_group" "dev_sg" {
  vpc_id = module.vpc.vpc_id
  name   = "dev-sg"

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
