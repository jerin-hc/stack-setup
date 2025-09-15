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
    id     = "size_management_rule"
    status = "Enabled"

    # Filter to apply the rule to objects larger than 10MB
    # This helps manage the bucket size by moving larger objects to cheaper storage
    filter {
      size_greater_than = 10485760  # 10MB in bytes
    }

    # Transition objects to STANDARD_IA after 30 days
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    # Transition objects to GLACIER after 60 days
    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    # Expire objects after 365 days
    expiration {
      days = 365
    }
  }

  # Add a quota rule to help manage total bucket size
  rule {
    id     = "quota_rule"
    status = "Enabled"

    # Apply to all objects (empty filter means all objects)
    filter {}

    # Set a noncurrent version expiration to limit versions
    noncurrent_version_expiration {
      noncurrent_days = 30
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