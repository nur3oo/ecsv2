variable "vpc_id" {
  description = "VPC ID"
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "private_subnet_ids" {
  description = "IDs of the private subnets"
  type        = list(string)
}

variable "db_name" {
  description = "Name of the database"
}

variable "db_username" {
  description = "Master username"
}

variable "rds_sg_id" {
  type = string
  
}