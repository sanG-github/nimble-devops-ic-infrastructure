# tfsec:ignore:aws-s3-encryption-customer-key tfsec:ignore:aws-s3-enable-bucket-encryption
resource "aws_s3_bucket" "this" {
  #checkov:skip=CKV2_AWS_61: There is no need to add lifecycle configuration to S3 bucket
  #checkov:skip=CKV2_AWS_62: There is no need to add event notification to S3 bucket
  #checkov:skip=CKV_AWS_145: There is no need to encrypt S3 bucket with KMS
  #checkov:skip=CKV_AWS_144: There is no need to replicate S3 bucket
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

resource "aws_s3_bucket_logging" "this" {
  bucket = aws_s3_bucket.this.id

  target_bucket = aws_s3_bucket.this.id
  target_prefix = local.target_prefix
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Enabled"
  }
}
