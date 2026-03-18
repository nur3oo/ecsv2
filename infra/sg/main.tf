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

resource "aws_security_group" "endpoint" {
    name = "endpoint-sg"
    description = "the security group for my vpc endpoint"
    vpc_id = var.vpc_id
  
  ingress {
    description = "only talk to aws services on port 443"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = var.private_subnet_cidrs[*].id

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vpc-endpoint-sg"
  }
}

