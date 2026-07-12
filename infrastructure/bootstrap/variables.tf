variable "region" {
    description = "Aws_region"
    type=string
    default="eu-west-3"
}
variable "bucket_name"{
    description = "Terrafrom state bucket"
    type=string
}
# variable "dynamo_table_name"{
#     description = "Terraform table for locking multi user"
#     type=string
# }