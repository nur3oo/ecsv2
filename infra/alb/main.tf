resource "aws_lb" "alb" {
    name = "app-alb"
    load_balancer_type = "application"  
    security_groups = [  ]
    subnets = [  ]
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

resource "aws_lb_listener" "HTTPS" {
    load_balancer_arn = aws_lb.alb.arn
    port = 443
    protocol = "HTTPS"

    default_action {
      type = "forward"
      target_group_arn = 
    }

  
}
  
