terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.s3_aws_access_key
  secret_key = var.s3_aws_secret_key
}