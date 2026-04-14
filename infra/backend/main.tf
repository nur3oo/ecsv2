terraform {
  backend "s3" {
    bucket         = "app-terraform-state1"
    key            = "prod/terraform.tfstate"
    region         = "eu-west-2"
    encrypt        = true
    use_lockfile = true
    
  }
}