resource "aws_lb" "alb" {
    name = "app-alb"
    load_balancer_type = "application"  
    security_groups = [  ]
    subnets = [  ]
}

resource "aws_lb_target_group" "tg" {
    name = "alb-tg"
    port = 443
    protocol = "HTTPS"
    vpc_id = var.aws_vpc.id
    target_type = "ip"

      health_check {
        protocol = "HTTPS"
        port = "traffic-port"
        path = "/"
        matcher = "200-399"
        interval = 30
        timeout = 5
        healthy_threshold = 2
        unhealthy_threshold = 2

      }

  
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.alb.arn
    port = 80
    protocol = "HTTP"

    default_action {
     type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
    load_balancer_arn = aws_lb.alb.arn
    port = 443
    protocol = "HTTPS"
    certificate_arn = 

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.tg.arn
    }

  
}

  
