# INTERNET GATEWAY #
resource "aws_internet_gateway" "igw" {
  vpc_id = module.vpc.vpc_id

  tags = merge(local.common_tags, { Name = "${var.environment_tag}-igw" })
}

# ROUTE TABLES #
resource "aws_route_table" "rtb" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.common_tags, { Name = "${var.environment_tag}-rtb" })
}

# SECURITY GROUPS #
resource "aws_security_group" "worker_group_mgmt_one" {
  name_prefix = "worker_group_mgmt_one"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
    ]
  }
}

resource "aws_security_group" "all_worker_mgmt" {
  name_prefix = "all_worker_management"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
      "172.16.0.0/12",
      "192.168.0.0/16",
    ]
  }
}

/*
# DEFINE A DEPLOYMENT
resource "kubernetes_deployment" "eks_deploy" {
  metadata {
    name = "${var.environment_tag}-eks-deploy"
    labels = {
      dev = "${local.tags.Name}"
    }
  }
  spec {
    replicas = "2"

    selector {
      match_labels = {
        dev = "${local.tags.Name}"
      }
    }

    template {
      metadata {
        labels = {
          dev = "${local.tags.Name}"
        }
      }
      spec {
        container {
          image = "nginx:1.7.8"
          name = "eks_deploy"

          resources {
            limits = {
              cpu = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "eks_service" {
  metadata {
    name = "${var.environment_tag}-eks-service"
  }
  spec {
    selector = {
      dev = "${local.tags.Name}"
    }
    port {
      port = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
*/
