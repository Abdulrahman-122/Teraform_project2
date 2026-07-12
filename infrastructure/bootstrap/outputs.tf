output "bucket_name"{
    value=aws_s3_bucket.Terrafrom_state.bucket
}
output "bucket_arn"{
    value=aws_s3_bucket.Terrafrom_state.arn
}
