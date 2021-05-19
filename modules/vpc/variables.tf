# AWS Variables

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "mwaa_aws_access_key" {
    type        = string
    description = "AWS Access Key"
}

variable "mwaa_aws_secret_key" {
    type        = string
    description = "AWS Secret Key"
}

# Custom Variables

variable "vpc_env_name" {
  type        = string
  description = "VPC Name"
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC ipv4 CIDR block"
}

variable "pub_subnet_1_cidr" {
  type        = string
  description = "Public Subnet 1 ipv4 CIDR block"
}

variable "pub_subnet_2_cidr" {
  type        = string
  description = "Public Subnet 2 ipv4 CIDR block"
}

variable "priv_subnet_1_cidr" {
  type        = string
  description = "Private Subnet 1 ipv4 CIDR block"
}

variable "priv_subnet_2_cidr" {
  type        = string
  description = "Private Subnet 2 ipv4 CIDR block"
}