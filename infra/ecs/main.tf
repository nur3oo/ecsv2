
resource "aws_ecs_cluster" "cluster" {
    name = "app-cluster"
  
}

resource "aws_cloudwatch_log_group" "ecs_cloudwatch" {
    name = "ecs-logs"
    retention_in_days = 7
  
}