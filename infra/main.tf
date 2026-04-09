module "ecs" {
    source = "./ecs"
    ecr_repository_url = module.ecr.ecr_repository_url
    ecs_sg = module.sg.ecs_sg
    private_subnet_ids = module.vpc.private_subnet_ids
    aws_lb_blue_target_group = module.alb.aws_lb_blue_target_group
  
}

module "alb" {
    source = "./alb"
    vpc_id =  = module.vpc.vpc_id
    public_subnets = module.vpc.public_subnets
    acm_cert = module.acm.acm_cert
    alb_sg = module.sg.alb_sg
  
}

module "backend" {
    source = "./backend"

  
}

module "bootstrap" {
    source = "./bootstrap"

  
}

module "certs" {
    source = "./certs"

  
}

module "codedeploy" {
    source = "./codedeploy"
    blue_tg = module.alb.blue_tg
    green_tg = module.alb.green_tg
    alb_https_listener = module.alb.alb_https_listener
    aws_lb_blue_target_group = module.alb.aws_lb_blue_target_group
    aws_lb_green_target_group = module.alb.aws_lb_green_target_group
    ecs_service = module.ecs.ecs_service
    cluster_name = module.ecs.cluster_name

}

module "database" {
    source = "./database"
    vpc_id = module.vpc.vpc_id
    private_subnet_ids = module.vpc.private_subnet_ids
    db_name = var.db_name
    db_username = var.db_username
    db_password = var.db_password

}

module "ecr" {
    source = "./ecr"

  
}
module "iam" {
    source = "./iam"

 
}

module "redis" {
    source = "./redis"
    name = var.name
    redis_sg = module.sg.redis_sg
    private_subnet_ids = module.vpc.private_subnet_ids
  
}

module "sg" {
  source = "./sg"
  vpc_id = module.vpc.vpc_id

}

module "vpc" {
    source = "./vpc"
    vpc_id = var.vpc_id
    endpoint_sg = module.sg.endpoint_sg
    private_subnets = var.private_subnet_ids
    public_subnets = var.public_subnets_ids
  
}

module "waf" {
    source = "./waf"
    aws_alb = module.alb.aws_lb
  
}