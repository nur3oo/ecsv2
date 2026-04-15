variable "cluster_name" {
    type = string
  
}

variable "ecs_service" {
    type = string
  
}

variable "service_name" {
    type = string
    default = "ecs-service"
  
}

variable "alb_https_listener" {
    type = string
  
}

variable "aws_lb_blue_target_group" {
    type = string
  
}

variable "aws_lb_green_target_group" {
    type = string
  
}

variable "green_tg" {
    type = string
  
}

variable "blue_tg" {
    type = string
}

variable "codedeploy_name" {
    type = string
    default = "app"
  
}

variable "deployment_group_name" {
    type = string
    default = "deployment"
  
}

variable "deployment_config_name" {
    type = string
    default = "CodeDeployDefault.ECSAllAtOnceue"
  
}

variable "codedeploy_role_arn" {
    type = string
  
}
