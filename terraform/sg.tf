module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "alb-sg-${random_pet.this.id}"
  description = "Security group for ALB"
  vpc_id      = aws_vpc.vpc_flugel.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "all-icmp"]
  egress_rules        = ["all-all"]
}

resource "random_pet" "this" {
  length = 2
}
