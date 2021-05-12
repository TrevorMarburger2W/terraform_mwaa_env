# AWS Variables

variable "aws_region" {
  type = string
  description = "AWS region"
}

# Environment Variable TF_VAR_s3_aws_access_key
variable "mwaa_aws_access_key" {
    type = string
    description = "AWS Access Key"
}

# Environment Variable TF_VAR_s3_aws_secret_key
variable "mwaa_aws_secret_key" {
    type = string
    description = "AWS Secret Key"
}

#Custom Variables

variable "bucket_name" {
  type = string
  description = "S3 Bucket Name"
}
