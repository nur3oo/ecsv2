variable "ecs_sg" {
    type = string
  
}

variable "cluster_name" {
    type = string
    default = "app-cluster"
  
}

variable "aws_lb_target_group" {
    type = string
  
}

variable "container_name" {
    default = "nur-ecs2"
    type = string

  
}

variable "container_port" {
  type = string
  default = "8080"
}

variable "private_subnet_ids" {
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
    default = "v1"
  
}