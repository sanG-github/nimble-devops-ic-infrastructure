resource "aws_cloudwatch_log_group" "this" {
  name              = local.namespace
  retention_in_days = local.retention_in_days
#  kms_key_id        = var.kms_key_id
}
