locals {
  user_data = <<EOF
#!/bin/bash
echo "Installing Traefik..."

    wget -O traefik.tgz https://github.com/traefik/traefik/releases/download/v2.4.9/traefik_v2.4.9_freebsd_amd64.tar.gz
    tar xzf traefik.tgz

EOF
}

module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"
  name                   = "traefik-cluster"
  instance_count         = 2

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.traefik_key.key_name
  monitoring             = false
  vpc_security_group_ids = []
  subnet_id              = aws_subnet.priv_sub.id
  user_data              = local.user_data
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "tls_private_key" "traefik_tls" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "traefik_key" {
  key_name   = "traefik-key"
  public_key = tls_private_key.traefik_tls.public_key_openssh
}

# ----------
# output "priv_key" {
#   value       = tls_private_key.traefik_tls.private_key_pem
#   description = "Private-key"
# }

