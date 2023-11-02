terraform {
  cloud {
    organization = "devops-ic"

    workspaces {
      tags = ["aws-infrastructure"]
    }
  }
}

module "vpc" {
  source = "../modules/vpc"
}

module "s3" {
  source = "../modules/s3"
}

module "security_group" {
  source = "../modules/security_group"

  vpc_id   = module.vpc.vpc_id
  app_port = local.app_port
}

module "alb" {
  source = "../modules/alb"

  vpc_id             = module.vpc.vpc_id
  app_port           = local.app_port
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_ids = module.security_group.alb_security_group_ids
  health_check_path  = local.health_check_path
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
