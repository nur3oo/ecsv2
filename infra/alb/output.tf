output "aws_lb" {
    value = aws_lb.alb.arn
  
}

output "aws_lb_target_group" {
    value = aws_lb_target_group.tg.arn
  
}