# AWS Variables

variable "aws_region" {
  type = string
  description = "AWS region"
}

variable "mwaa_aws_access_key" {
    type = string
    description = "AWS Access Key"
}

variable "mwaa_aws_secret_key" {
    type = string
    description = "AWS Secret Key"
}

# Custom Variables

variable "vpc_env_name" {
  type = string
  description = "VPC Name"
}

variable "vpc_cidr_block" {
  type = string
  description = "VPC ipv4 CIDR block"
}