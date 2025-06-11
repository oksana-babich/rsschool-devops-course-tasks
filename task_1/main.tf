provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket         = "remote-state-bucket-devops-course"
    key            = "terraform/state"
    region         = "eu-central-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}


