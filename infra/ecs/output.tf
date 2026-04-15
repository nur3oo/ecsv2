output "ecs_cluster_id" {
    value = aws_ecs_cluster.cluster.id
  
}

output "ecs_cluster_arn" {
    value = aws_ecs_cluster.cluster.arn
  
}

output "task_definition" {
    value = aws_ecs_task_definition.task.arn
  
}

output "cloudwatch" {
    value = aws_cloudwatch_log_group.ecs_cloudwatch.arn
  
}

output "cluster_name" {
    value = aws_ecs_cluster.cluster.name
  
}

output "ecs_service" {
    value = aws_ecs_service.service.id
  
}

