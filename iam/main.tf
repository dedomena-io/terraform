provider "aws" {
  region = "us-west-2"
}

# Use data from main
data "terraform_remote_state" "vpc_dev" {
  backend  = "s3"
  config = {
    bucket = "dd-state"
    key    = "main/terraform.state"
    region = "us-west-2"
  }
}

# Output remote data to remote state file
terraform {
  required_version = ">= 0.12"
  backend "s3" {
    bucket = "dd-state"
    key    = "iam/terraform.state"
  }
}
