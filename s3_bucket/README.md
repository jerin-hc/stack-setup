# AWS S3 Bucket Module

This Terraform module creates an S3 bucket with size management features.

## Features

- Creates an S3 bucket with configurable name
- Implements lifecycle rules to manage storage costs and indirectly control bucket size:
  - Transitions objects larger than 10MB to STANDARD_IA after 30 days
  - Transitions objects to GLACIER after 60 days
  - Expires objects after 365 days
  - Expires noncurrent versions after 30 days
- Configurable versioning
- Server-side encryption with AES256

## Usage

```hcl
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
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket_name | The name of the S3 bucket | `string` | n/a | yes |
| environment | The environment (e.g., dev, staging, prod) | `string` | `"dev"` | no |
| enable_versioning | Whether to enable versioning for the bucket | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket_id | The ID of the S3 bucket |
| bucket_arn | The ARN of the S3 bucket |
| bucket_domain_name | The domain name of the S3 bucket |
| bucket_regional_domain_name | The regional domain name of the S3 bucket |