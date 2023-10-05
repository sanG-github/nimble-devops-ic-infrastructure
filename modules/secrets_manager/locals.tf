locals {
  # Description of the KMS key
  description = "KMS key for CloudWatch service"

  # The namespace for the KMS
  namespace = "devops-ic-kms"

  # Enable key rotation
  enable_key_rotation = true

  # Create a secrets ARN collection for granting "secretsmanager:GetSecretValue" permission
  secret_arns = [for secret in aws_secretsmanager_secret.service_secrets : secret.arn]

  # Get Secret Names Array
  secret_names = keys(var.secrets)

  # Create a secrets map { secret_name : secret_arn } using ZipMap Function for iteration
  secrets_name_arn_map = zipmap(local.secret_names, local.secret_arns)

  # Create secrets formatted for the Task Definition
  secrets_variables = [for secret_key, secret_arn in local.secrets_name_arn_map :
    tomap({ "name" = upper(secret_key), "valueFrom" = secret_arn })
  ]
}
