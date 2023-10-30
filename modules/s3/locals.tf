locals {
  # The name of the bucket
  asset_bucket_name = "devops-ic-assets-bucket"

  # The name of ALB log bucket
  alb_log_bucket_name = "devops-ic-alb-log-bucket"

  # All objects should be deleted from the bucket when the bucket is destroyed
  force_destroy = true

  # Prefix for logs of the bucket
  log_target_prefix = "logs/"
}
