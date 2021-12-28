resource "aws_security_group" "sg" {
  name   = "${local.env_name}-sg"
  vpc_id = module.vpc.vpc_id

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

resource "aws_internet_gateway" "igw" {
  vpc_id = module.vpc.vpc_id

  tags = merge(local.common_tags, { Name = "${var.environment_tag}-igw" })
}

variable "environment_tag-subnet" {
  default = ""
}
resource "aws_subnet" "subnet" {
  count             = var.subnet_count
  cidr_block        = cidrsubnet(var.network_address_space, 8, count.index)
  vpc_id            = module.vpc.vpc_id
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = merge(local.common_tags, { Name = "${var.environment_tag}-subnet${count.index + 1}" })
}

resource "aws_route_table" "rtb" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.common_tags, { Name = "${var.environment_tag}-rtb" })
}

resource "aws_route_table_association" "rta-subnet" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.subnet[count.index].id
  route_table_id = aws_route_table.rtb.id
}


