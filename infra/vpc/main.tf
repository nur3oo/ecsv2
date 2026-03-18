data "aws_availability_zones" "available" {
  state = "available"
}
// data look up of availabe AZs and reference it in my subnets



resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    
}

resource "aws_subnet" "public" {
  vpc_id = var.vpc_id
  count = 2
  cidr_block = [ 10.0.1.0/24 ]
  availability_zone = data.aws_availability_zones.available
  
}

resource "aws_subnet" "private" {
  vpc_id = var.vpc_id
  count = 2
  cidr_block = 
  availability_zone = data.aws_availability_zones.available

}

resource "aws_vpc_endpoint" "endpoint" {
  vpc_id = var.vpc_id
  
}