variable "ecs_sg" {
    type = string
  
}

variable "cluster_name" {
    type = string
    default = "app-cluster"
  
}


variable "container_name" {
    default = "nur-app"
    type = string

  
}

variable "container_port" {
  type = string
  default = "8080"
}

variable "private_subnets" {
  type = list(string)
}

variable "service_name" {
    type = string
    default = "ecs-service"
  
}

variable "ecr_repository_url" {
    type = string
  
}

variable "image_tag" {
    type = string
    default = "latest"
  
}

variable "aws_lb_blue_target_group" {
    type = string
  
}

variable "ecs_execution_role_arn" {
    type = string
  
}

variable "ecs_task_role_arn" {
    type = string
  
}

variable "rds_pass" {
    type = string
  
}