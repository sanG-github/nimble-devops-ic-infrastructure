resource "aws_kms_key" "secret_key_arn" {
  description         = local.description
  enable_key_rotation = local.enable_key_rotation
}

resource "aws_kms_key_policy" "secret_key_arn_policy" {
  key_id = aws_kms_key.secret_key_arn.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "secret_key_arn_policy"
    Statement = [
      {
        Action = "kms:*"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }

        Resource = "*"
        Sid      = "Enable IAM User Permissions"
      }
    ]
  })
}

resource "aws_secretsmanager_secret" "service_secrets" {
  #checkov:skip=CKV2_AWS_57: There is no need to enable key rotation
  for_each = var.secrets

  name                    = "${local.namespace}/${lower(each.key)}"
  description             = "Secret `${lower(each.key)}` for ${local.namespace}"
  kms_key_id              = aws_kms_key.secret_key_arn.arn
  recovery_window_in_days = 0

  tags = {
    Name = "${local.namespace}-secrets-manager"
  }
}
