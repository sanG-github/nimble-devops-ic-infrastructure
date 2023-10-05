# tfsec:ignore:aws-s3-enable-versioning tfsec:ignore:aws-s3-enable-bucket-logging tfsec:ignore:aws-s3-encryption-customer-key tfsec:ignore:aws-s3-enable-bucket-encryption
resource "aws_s3_bucket" "this" {
  bucket        = local.bucket_name
  force_destroy = local.force_destroy
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
