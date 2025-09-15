variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "my-terraform-s3-bucket"
}

variable "environment" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

# These variables are referenced in the existing components.tfstack.hcl file
# but are not used by our S3 module directly
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "prefix" {
  description = "Prefix to use for resource naming"
  type        = string
  default     = "terraform"
}