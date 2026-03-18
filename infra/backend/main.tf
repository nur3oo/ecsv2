terraform {
  backend "s3" {
    bucket         = var.state_bucket_name
    key            = "prod/terraform.tfstate"
    region         = var.region
    encrypt        = true
    dynamodb_table = var.dynamodb_table_name
  }
}