resource "aws_s3_bucket" "this" {
  bucket        = local.bucket_name
  force_destroy = local.force_destroy
}
