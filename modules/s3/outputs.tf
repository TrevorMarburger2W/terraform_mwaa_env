output "s3_arn" {
    value = aws_s3_bucket.mwaa_bucket.arn
}

output "bucket_dag_key" {
    value = aws_s3_bucket_object.folder1.key
}