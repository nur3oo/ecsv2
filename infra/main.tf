module "ecs" {
    source = "./ecs"
    ecr_repository_url = module.ecr.ecr_repository_url
    ecs_sg = module.sg.ecs_sg
    private_subnet_ids = module.vpc.private_subnet_ids
    aws_lb_blue_target_group = module.alb.aws_lb_blue_target_group

  
}


