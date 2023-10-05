locals {
  # The name of the bucket
  bucket_name = "devops-ic-bucket"

  # All objects should be deleted from the bucket when the bucket is destroyed
  force_destroy = true

  # Prefix for logs of the bucket
  target_prefix = "logs/bucket"
}
