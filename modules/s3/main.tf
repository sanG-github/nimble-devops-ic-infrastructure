resource "aws_s3_bucket" "main_bucket" {
  bucket        = local.bucket_name
  force_destroy = local.force_destroy
}

resource "aws_s3_bucket" "log_bucket" {
  bucket        = local.log_bucket_name
  force_destroy = local.force_destroy
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.main_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_logging" "this" {
  bucket = aws_s3_bucket.main_bucket.id

  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "logs/main_bucket/"
}
