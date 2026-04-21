module "ecs" {
    source = "./ecs"
    ecr_repository_url = module.ecr.ecr_repository_url
    ecs_sg = module.sg.ecs_sg
    aws_lb_blue_target_group = module.alb.aws_lb_blue_target_group
    rds_pass = module.database.rds_pass
    ecs_execution_role_arn = module.iam.ecs_execution_role_arn
    ecs_task_role_arn = module.iam.ecs_task_role_arn
    private_subnets = module.vpc.private_subnets
}

module "alb" {
    source = "./alb"
    vpc_id =   module.vpc.vpc_id
    public_subnets = module.vpc.public_subnets
    acm_cert = module.certs.acm_cert
    alb_sg = module.sg.alb_sg
  
}

module "bootstrap" {
    source = "./bootstrap"


}

module "certs" {
    source = "./certs"
    alb_dns = module.alb.alb_dns
    cloudflare_zone_id = var.cloudflare_zone_id
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
    codedeploy_role_arn = module.iam.codedeploy_role_arn
}

module "database" {
    source = "./database"
    vpc_id = module.vpc.vpc_id
    private_subnet_ids = module.vpc.private_subnets
    db_name = var.db_name
    db_username = var.db_username
    rds_sg_id = module.sg.rds_sg_id

}

module "ecr" {
    source = "./ecr"

  
}
module "iam" {
    source = "./iam"
    rds_pass = module.database.rds_pass

 
}

module "redis" {
    source = "./redis"
    name = var.name
    redis_sg = module.sg.redis_sg
    private_subnet_ids = module.vpc.private_subnets
  
}

module "sg" {
  source = "./sg"
  vpc_id = module.vpc.vpc_id

}

module "vpc" {
    source = "./vpc"
    endpoint_sg = module.sg.endpoint_sg



}

module "waf" {
    source = "./waf"
    aws_alb = module.alb.aws_lb

}