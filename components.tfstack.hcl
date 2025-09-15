variable "bucket_name" {
  type = string
  description = "The name of the S3 bucket"
}

variable "environment" {
  type = string
  description = "The environment (e.g., dev, staging, prod)"
}

provider "aws" {
  alias = "this"
  region = "us-east-1"
}

component "s3_storage" {
  source = "./s3_bucket"
  inputs = {
    bucket_name       = var.bucket_name
    environment       = var.environment
    enable_versioning = true
  }
  providers = {
    aws = provider.aws.this
  }
}