resource "aws_kms_key" "service_key" {
  description         = local.description
  enable_key_rotation = local.enable_key_rotation
}

resource "aws_secretsmanager_secret" "service_secrets" {
  for_each = var.secrets

  name                    = "${local.namespace}/${lower(each.key)}"
  description             = "Secret `${lower(each.key)}` for ${local.namespace}"
  kms_key_id              = aws_kms_key.service_key.arn
  recovery_window_in_days = 0

  tags = {
    Name = "${local.namespace}-secrets-manager"
  }
}