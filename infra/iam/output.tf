output "ecs_execution_role_arn" {
  description = "ARN of the ECS execution role"
  value       = aws_iam_role.ecs_execution_role.arn
}

output "ecs_execution_role_name" {
  description = "Name of the ECS execution role"
  value       = aws_iam_role.ecs_execution_role.name
}

output "ecr_execution_role_arn" {
    description = "id for ECR role"
    value = aws_iam_role_policy.ecs_ecr.id
  
}

output "ecs_task_role_arn" {
  value = aws_iam_role.ecs_task_role.arn
}

output "ecs_lb" {
  value = aws_iam_role.ecs_lb.arn
  
}

output "codedeploy_role_arn" {
  value = aws_iam_role.codedeploy.arn
}

