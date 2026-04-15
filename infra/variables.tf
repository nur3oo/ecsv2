variable "cloudflare_api_token" {
  type = string
}

variable "db_name" {
  description = "Name of the database"
  default = "database"
}

variable "db_username" {
  description = "Master username"
  default = "theuser"
}

##redis

variable "name" {
  description = "Name of Redis"
  default = "redis"
  
}

##vpc

variable "public_subnets_ids" {
  type = list(string)

  
}

variable "private_subnet_ids" {
  type = list(string)
  
}
