data "aws_availability_zones" "available" {
  state = "available"
}
// data look up of availabe AZs and reference it in my subnets



resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    
    
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  count = var.count
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id
  count = var.count
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  
}


resource "aws_vpc_endpoint" "s3" {
  vpc_id = aws_vpc.main.id
  vpc_endpoint_type = "Gateway"
  route_table_ids = [aws_route_table.private.id]
  service_name = "com.amazonaws.${var.region}.s3"
}

