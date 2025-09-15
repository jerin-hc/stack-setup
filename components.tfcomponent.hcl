variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
}

variable "environment" {
  type        = string
  description = "The environment (e.g., dev, staging, prod)"
}

component "s3_storage" {
  source = "./s3_bucket"

  providers = {
    aws = provider.aws.s3
  }
  inputs = {
    bucket_name = var.bucket_name
    environment = var.environment
  }
}