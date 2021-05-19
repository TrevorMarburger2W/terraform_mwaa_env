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

#Custom Variables

variable "bucket_name" {
  type        = string
  description = "S3 Bucket Name"
}

variable "dag_path" {
  type        = string
  description = "Dag Folder name"
}