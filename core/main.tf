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

  environment = var.environment
}

module "security_group" {
  source = "../modules/security_group"

  environment                    = var.environment
  vpc_id                         = module.vpc.vpc_id
  app_port                       = local.app_port
  rds_port                       = local.current_rds_config.port
  elasticache_port               = local.current_elasticache_config.port
  private_subnets_cidr_blocks    = module.vpc.private_subnets_cidr_blocks
  bastion_allowed_ip_connections = local.bastion_allowed_ip_connections
}

module "alb" {
  source = "../modules/alb"

  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  app_port           = local.app_port
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_ids = module.security_group.alb_security_group_ids
  health_check_path  = local.health_check_path
}

module "cloudwatch" {
  source = "../modules/cloudwatch"

  environment = var.environment
  kms_key_id  = module.secrets_manager.secret_key_arn
}

module "secrets_manager" {
  source = "../modules/secrets_manager"

  environment = var.environment
  secrets = {
    database_url    = module.rds.db_url
    redis_url       = module.elasticache.redis_primary_endpoint
    secret_key_base = var.secret_key_base
  }
}

module "ecs" {
  source = "../modules/ecs"

  environment                        = var.environment
  region                             = local.region
  app_port                           = local.app_port
  ecr_repo_name                      = local.ecr_repo_name
  health_check_path                  = local.health_check_path
  subnets                            = module.vpc.private_subnet_ids
  security_groups                    = module.security_group.ecs_security_group_ids
  alb_target_group_arn               = module.alb.alb_target_group_arn
  aws_cloudwatch_log_group_name      = module.cloudwatch.aws_cloudwatch_log_group_name
  deployment_maximum_percent         = local.current_ecs_config.deployment_maximum_percent
  deployment_minimum_healthy_percent = local.current_ecs_config.deployment_minimum_healthy_percent
  web_container_cpu                  = local.current_ecs_config.web_container_cpu
  web_container_memory               = local.current_ecs_config.web_container_memory
  task_desired_count                 = local.current_ecs_config.task_desired_count
  max_capacity                       = local.current_ecs_config.max_capacity
  max_cpu_threshold                  = local.current_ecs_config.max_cpu_threshold

  environment_variables = local.current_environment_variables
  secrets_variables     = module.secrets_manager.secrets_variables
  secret_arns           = module.secrets_manager.secret_arns
}

module "rds" {
  source = "../modules/rds"

  environment            = var.environment
  vpc_security_group_ids = module.security_group.rds_security_group_ids
  vpc_id                 = module.vpc.vpc_id
  subnet_ids             = module.vpc.private_subnet_ids

  database_name = var.environment
  username      = var.rds_username
  password      = var.rds_password

  instance_type            = local.current_rds_config.instance_type
  port                     = local.current_rds_config.port
  autoscaling_min_capacity = local.current_rds_config.autoscaling_min_capacity
  autoscaling_max_capacity = local.current_rds_config.autoscaling_max_capacity
}

module "elasticache" {
  source = "../modules/elasticache"

  environment        = var.environment
  node_type          = local.current_elasticache_config.node_type
  port               = local.current_elasticache_config.port
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_ids = module.security_group.elasticache_security_group_ids
  auth_token         = var.redis_auth_token
  kms_key_id         = module.secrets_manager.secret_key_arn
}

module "bastion" {
  source = "../modules/bastion"

  environment                 = var.environment
  subnet_ids                  = module.vpc.public_subnet_ids
  instance_security_group_ids = module.security_group.bastion_security_group_ids
}
