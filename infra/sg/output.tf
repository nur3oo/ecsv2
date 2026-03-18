output "alb_sg" {
    description = "the id for my alb sg"
    value = aws_security_group.alb.id
  
}

output "endpoint_sg" {
    description = "the id for my endpoint sg"
    value = aws_security_group.endpoint.id
  
}

output "ecs_sg" {
    description = "the id for my ecs sg"
    value = aws_security_group.ecs.id
  
}