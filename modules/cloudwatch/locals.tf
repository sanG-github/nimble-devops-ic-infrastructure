locals {
  # The namespace for the CloudWatch log group
  namespace = "${var.environment}-devops-ic-cloudwatch"

  # Log retention in days
  retention_in_days = 400
}
