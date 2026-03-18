resource "aws_security_group" "alb" {
    name = "alb-sg"
    vpc_id = var.vpc_id

  ingress {
    description = "HTTPS from internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    

    egress {
      description = "to talk to the ecs task" 
      from_port = 8080
      to_port = 8080
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]

    

    }
  
}

resource "aws_security_group" "ecs" {
    name = "ecs-sg"
    vpc_id = var.vpc_id

  ingress {
    description = "sg for ecs from alb"
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    security_groups = [aws_security_group.alb.id]
      }
  
}

