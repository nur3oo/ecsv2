variable "vpc_id" {
    type = string
  
}

variable "private_subnets" {
    type = string
  
}

variable "public_subnets" {
    type = string
  
}


variable "public_subnet_cidrs" {
  description = "cid blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "cid blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "endpoint_sg" {
    type = string
  
}

variable "region" {
    type = string
    default = "eu-west-2"
  
}