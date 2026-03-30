output "aws_lb" {
    value = aws_lb.alb.arn
  
}

output "aws_lb_blue_target_group" {
    value = aws_lb_target_group.blue.arn
  
}

output "aws_lb_green_target_group" {
    value = aws_lb_target_group.green.arn
  
}

output "green_tg" {
    value = aws_lb_target_group.green.name
  
}

output "blue_tg" {
    value = aws_lb_target_group.blue.name
  
}



output "alb_https_listener" {
    value = aws_lb_listener.https.arn
  
}