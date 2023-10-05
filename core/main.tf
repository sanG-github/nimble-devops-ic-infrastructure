terraform {
  cloud {
    organization = "devops-ic"

    workspaces {
      tags = ["aws-infrastructure"]
    }
  }
}

module "cloudwatch" {
  source = "../modules/cloudwatch"

  kms_key_id = module.secrets_manager.secret_cloudwatch_log_key_arn
}

module "secrets_manager" {
  source = "../modules/secrets_manager"

  secrets = {
    secret_key_base = var.secret_key_base
  }
}

module "vpc" {
  source = "../modules/vpc"
}
