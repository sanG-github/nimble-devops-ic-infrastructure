locals {
  # The name of the bucket
  bucket_name = "devops-ic-bucket"

  # The name of the log bucket
  log_bucket_name = "devops-ic-log-bucket"

  # All objects should be deleted from the bucket when the bucket is destroyed
  force_destroy = true
}
