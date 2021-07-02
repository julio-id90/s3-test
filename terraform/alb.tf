module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "flugel-alb"

  load_balancer_type = "application"

  vpc_id             = aws_vpc.vpc_flugel.id
  subnets            = [aws_subnet.pub_sub.id, aws_subnet.priv_sub.id]

  target_groups = [
    {
      name_prefix      = "pre-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = [
        {
            target_id = module.ec2_cluster.id[0]
            port      = 80
        },
        {
            target_id = module.ec2_cluster.id[1]
            port      = 80
        }
      ]
    }
  ]

  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      # action_type = "forward"
      target_group_index = 0
    }
  ]

  tags = {
    Environment = "Flugel"
  }
}

output "alb_dns" {
    description = "alb frontend dns"
    value       = module.alb.lb_dns_name
}

output "alb_instances" {
    description = "alb instances attached"
    value       = module.ec2_cluster.id
}

