variable "region" {
    default = "eu-west-2"
  
}

variable "state_bucket_name" {
  default = "s3"
}

variable "dynamodb_table_name" {
    default = "terraform-state-locks"
  
}