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

  # The ECS configuration for the current environment
  current_ecs_config = local.ecs_config[var.environment]

  # ECS configurations for each environment
  ecs_config = {
    staging    = jsondecode(file("assets/ecs_configs/staging.json"))
    production = jsondecode(file("assets/ecs_configs/production.json"))
  }
}
