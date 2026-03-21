
resource "aws_ecs_cluster" "cluster" {
    name = "app-cluster"
  
}

resource "aws_cloudwatch_log_group" "ecs_cloudwatch" {
    name = "ecs-logs"
    retention_in_days = 7
  
}

resource "aws_ecs_task_definition" "task" {
    family = "nur-ecs"
    requires_compatibilities = ["FARGATE"]
    network_mode = "awsvpc"
    cpu = 256
    memory = 512
    execution_role_arn = aws_iam_role.ecs_execution_role.arn
    task_role_arn = aws_iam_role.ecs_task_role.arn

    container_definitions = jsonencode([{
  name      = "nur-app"
  image     = 
  essential = true

  portMappings = [{
    containerPort = 8080   
    protocol      = "tcp"
  }]

  secrets = [{
    name      = "DATABASE_URL"
    valueFrom = data.aws_secretsmanager_secret.db_password.arn
  }]

  logConfiguration = {
    logDriver = "awslogs"
    options = {
      "awslogs-group"         = "/ecs/nur-app"
      "awslogs-region"        = "eu-west-2"
      "awslogs-stream-prefix" = "ecs"
    }
  }
}])



  
}

resource "aws_ecs_service" "service" {
    name = var.service_name
    cluster = aws_ecs_cluster.cluster.id
    task_definition = aws_ecs_task_definition.task.arn
    desired_count = 2
    launch_type = "FARGATE"
    force_new_deployment = true

    network_configuration {
      subnets = var.private_subnet_ids
      security_groups = [var.ecs_sg]
      assign_public_ip = false
    }

    load_balancer {
      target_group_arn = var.aws_lb_target_group
      container_name = var.container_name
      container_port = var.container_port
    }
}