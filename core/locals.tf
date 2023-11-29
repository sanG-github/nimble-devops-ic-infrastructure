locals {
  # Application name
  app_name = "nimble-devops-ic-web"

  # The owner of the infrastructure, used to tag the resources, e.g. `acme-web`
  owner = "sanghuynh20000"

  # The repository name of the ECR to retrieve the image from
  ecr_repo_name = "devops-ic-ecr"

  # AWS region
  region = "ap-southeast-1"

  # The application exposed port
  app_port = 3000

  # The health check path of the Application
  health_check_path = "/health"

  # The IP addresses allowed to connect to the bastion host
  bastion_allowed_ip_connections = []

  # The ECS configuration for the current environment
  current_ecs_config = local.ecs_config[var.environment]

  # ECS configurations for each environment
  ecs_config = {
    staging    = jsondecode(file("assets/ecs_configs/staging.json"))
    production = jsondecode(file("assets/ecs_configs/production.json"))
  }

  # ENV variables for the current environment
  current_environment_variables = local.environment_variables[var.environment]

  # ENV variables for each environment
  environment_variables = {
    staging    = [for k, v in jsondecode(file("assets/environment_variables/staging.json")) : { name = k, value = v }]
    production = [for k, v in jsondecode(file("assets/environment_variables/production.json")) : { name = k, value = v }]
  }

  current_rds_config = local.rds_config[var.environment]

  rds_config = {
    staging = {
      instance_type            = "db.t3.medium"
      port                     = 5432
      autoscaling_min_capacity = 0
      autoscaling_max_capacity = 3
    }

    production = {
      instance_type            = "db.t3.medium"
      port                     = 5432
      autoscaling_min_capacity = 1
      autoscaling_max_capacity = 3
    }
  }

  current_elasticache_config = local.elasticache_config[var.environment]

  elasticache_config = {
    staging = {
      node_type = "cache.t2.micro"
      port      = 6379
    }

    production = {
      node_type = "cache.t2.micro"
      port      = 6379
    }
  }
}
