locals {
  # The name of the bucket
  asset_bucket_name = "${var.environment}-devops-ic-assets-bucket"

  # The name of ALB log bucket
  alb_log_bucket_name = "devops-ic-alb-log-bucket"

  # All objects should be deleted from the bucket when the bucket is destroyed
  force_destroy = true

  # Prefix for logs of the bucket
  log_target_prefix = "logs/"

  # The number of days after which to expire log objects
  alb_logs_expiration_in_days = 90

  # Allow ALB to write log to S3 bucket
  aws_s3_alb_log_bucket_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = [
            "${data.aws_elb_service_account.elb_service_account.arn}"
          ]
        }
        Action   = "s3:PutObject"
        Resource = "arn:aws:s3:::${aws_s3_bucket.alb_log.id}/AWSLogs/*"
      },
      {
        Effect = "Allow"
        Principal = {
          Service = "delivery.logs.amazonaws.com"
        }
        Action   = "s3:PutObject"
        Resource = "arn:aws:s3:::${aws_s3_bucket.alb_log.id}/AWSLogs/*",
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      },
      {
        Effect = "Allow"
        Principal = {
          Service = "delivery.logs.amazonaws.com"
        }
        Action   = "s3:GetBucketAcl"
        Resource = "arn:aws:s3:::${aws_s3_bucket.alb_log.id}"
      }
    ]
  }
}
