locals {
  # The namespace for the ECS
  namespace = "devops-ic-ecs"

  ecr_tag                            = "${local.namespace}-app"

  # Environment variables from other variables
  environment_variables = toset([
    { name = "AWS_REGION", value = var.region },
    { name = "HEALTH_CHECK_PATH", value = var.health_check_path },
    { name = "APP_PORT", value = var.app_port }
  ])

  container_vars = {
    namespace                     = local.namespace
    region                        = var.region
    app_port                      = var.app_port
    aws_ecr_repository            = data.aws_ecr_repository.repo.repository_url
    aws_ecr_tag                   = local.ecr_tag
    aws_cloudwatch_log_group_name = var.aws_cloudwatch_log_group_name

    environment_variables = local.environment_variables
    secrets_variables     = var.secrets_variables
  }

  container_definitions = templatefile("${path.module}/service.json.tftpl", local.container_vars)

  ecs_task_execution_kms_policy = {
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:CreateGrant",
          "kms:DescribeKey",
        ],
        Resource = "arn:aws:kms:*:*:key/*"
      }
    ]
  }

  ecs_task_execution_secrets_manager_policy = {
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue"
        ],
        Resource = var.secret_arns
      }
    ]
  }
}
