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

output "rds_sg_id" {
  description = "Security group is for RDS"
  value       = aws_security_group.rds.id
}

output "redis_sg" {
    description = "Security group for redis"
    value = aws_security_group.rds.id
  
}