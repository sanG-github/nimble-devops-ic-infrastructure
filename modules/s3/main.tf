# S3 bucket for storing assets

# tfsec:ignore:aws-s3-encryption-customer-key tfsec:ignore:aws-s3-enable-bucket-encryption
resource "aws_s3_bucket" "asset_bucket" {
  #checkov:skip=CKV2_AWS_61: There is no need to add lifecycle configuration to S3 bucket
  #checkov:skip=CKV2_AWS_62: There is no need to add event notification to S3 bucket
  #checkov:skip=CKV_AWS_145: There is no need to encrypt S3 bucket with KMS
  #checkov:skip=CKV_AWS_144: There is no need to replicate S3 bucket
  bucket        = local.asset_bucket_name
  force_destroy = local.force_destroy
}

resource "aws_s3_bucket_public_access_block" "asset_bucket" {
  bucket = aws_s3_bucket.asset_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_logging" "asset_bucket" {
  bucket = aws_s3_bucket.asset_bucket.id

  target_bucket = aws_s3_bucket.asset_bucket.id
  target_prefix = local.log_target_prefix
}

resource "aws_s3_bucket_versioning" "asset_bucket" {
  bucket = aws_s3_bucket.asset_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# S3 bucket for storing ALB logs

# tfsec:ignore:aws-s3-encryption-customer-key tfsec:ignore:aws-s3-enable-bucket-encryption
resource "aws_s3_bucket" "alb_log" {
  #checkov:skip=CKV2_AWS_61: There is no need to add lifecycle configuration to S3 bucket
  #checkov:skip=CKV2_AWS_62: There is no need to add event notification to S3 bucket
  #checkov:skip=CKV_AWS_145: There is no need to encrypt S3 bucket with KMS
  #checkov:skip=CKV_AWS_144: There is no need to replicate S3 bucket
  bucket        = local.alb_log_bucket_name
  force_destroy = local.force_destroy
}

resource "aws_s3_bucket_acl" "alb_log_bucket_acl" {
  bucket = aws_s3_bucket.alb_log.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "alb_log" {
  bucket = aws_s3_bucket.alb_log.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_logging" "alb_log" {
  bucket = aws_s3_bucket.alb_log.id

  target_bucket = aws_s3_bucket.alb_log.id
  target_prefix = local.log_target_prefix
}

resource "aws_s3_bucket_versioning" "alb_log" {
  bucket = aws_s3_bucket.alb_log.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "allow_elb_logging" {
  bucket = aws_s3_bucket.alb_log.id
  policy = jsonencode(local.aws_s3_alb_log_bucket_policy)
}

resource "aws_s3_bucket_lifecycle_configuration" "delete_expired_alb_logs_lifecycle" {
  bucket = aws_s3_bucket.alb_log.id

  rule {
    id     = "expire-alb-logs"
    status = "Enabled"

    expiration {
      days = local.alb_logs_expiration_in_days
    }
  }
}
