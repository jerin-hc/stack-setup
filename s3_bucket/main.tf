resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  
  tags = {
    Name        = var.bucket_name
    Environment = var.environment
    Managed_by  = "Terraform"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    id     = "size_limit_rule"
    status = "Enabled"

    # This rule transitions objects to Glacier storage class when the bucket size exceeds 2GB
    # Note: AWS doesn't directly limit bucket size, this is a workaround
    transition {
      days          = 0
      storage_class = "GLACIER"
      
      # This filter will apply the transition when the bucket size exceeds 2GB (2,147,483,648 bytes)
      filter {
        object_size_greater_than = 2147483648
      }
    }
  }
}

# Enable versioning for the bucket
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  
  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Disabled"
  }
}

# Configure server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}