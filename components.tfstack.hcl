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