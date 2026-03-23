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
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  
}

resource "aws_subnet" "private" {
  vpc_id = var.vpc_id
  count = 2
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available

}

resource "aws_vpc_endpoint" "endpoint" {
  vpc_id = var.vpc_id
  vpc_endpoint_type = "Interface"
  subnet_ids = var.private_subnets[*].id
  
}