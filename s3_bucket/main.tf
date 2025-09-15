resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    id     = "expire_after_30_days"
    status = "Enabled"

    filter {} # required, empty = all objects

    expiration {
      days = 30
    }
  }
}
