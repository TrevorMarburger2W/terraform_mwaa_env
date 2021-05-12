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

variable "bucket_arn" {
  type = string
  description = "Default S3 Bucket ARN"
}

variable "dag_path" {
  type = string
  description = "Dag key in S3 Bucket"
}

# Custom Variables

variable "work_env" {
    type = string
    description = "Environment ex.: dev/prod"
}

variable "sec_group_id" {
  type = string
  description = "MWAA VPC Security Group"
}

variable "subnet_ids" {
  type = list(string)
  description = "MWAA VPC Private Subnets"
}

variable "execution_role" {
  type = string
  description = "MWAA Execution Role ARN"
}

variable "mwaa_webserver_access_mode" {
  type = string
  description = "Public OR Private MWAA UI access (PUBLIC_ONLY -or- PRIVATE_ONLY)"
}