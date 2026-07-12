resource "aws_s3_bucket" "Terrafrom_state"{
    bucket=var.bucket_name
    tags={
        Name= "Terraform-state"
        Environment="Bootstrap"
    }
}

resource "aws_s3_bucket_versioning" "Terraform_state1"{
    bucket=aws_s3_bucket.Terrafrom_state.id
    versioning_configuration{
        status="Enabled"
    }
}
resource "aws_s3_bucket_server_side_encryption_configuration" "Terraform_state2"{
    bucket=aws_s3_bucket.Terrafrom_state.id
    rule{
        apply_server_side_encryption_by_default{
            sse_algorithm="AES256"
        }
    }
}
resource "aws_s3_bucket_public_access_block" "Terraform_state3"{
    bucket=aws_s3_bucket.Terrafrom_state.id
    block_public_acls=true
    block_public_policy = true
    ignore_public_acls=true
    restrict_public_buckets = true
}