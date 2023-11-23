This document outlines the software and hardware requirements for running the infrastructure of the [example app](https://github.com/SanG-github/nimble-devops-ic-web). You can refer to the [[Architecture Diagram]] for a visual overview of the infrastructure components.

## Required Hardware

The infrastructure is hosted on AWS and relies on various AWS services, including ECS with Fargate launch type, RDS, and ElastiCache. Migrating to a different cloud provider is possible, thanks to Terraform's flexibility.

### RDS Instance Type

- Instance Type: `db.t3.micro`

### ElastiCache Node Type

- Node Type: `cache.t2.micro`

### ECS Fargate Instance Type

The ECS Fargate instance type is dynamically determined based on the environment-specific file stored within the assets/ecs_configs folder. This file, named after the environment, dictates essential configurations for ECS. It encompasses settings like `task_desired_count`, `web_container_cpu`, `web_container_memory`, `deployment_maximum_percent`, `deployment_minimum_healthy_percent`, `max_capacity`, and `max_cpu_threshold`. These configurations must be explicitly defined within this designated file to accurately configure ECS behavior.

## Required Software

The infrastructure is managed and modified using Terraform Cloud. Whenever code changes are pushed to the respective branch, a Terraform plan is automatically performed for the associated infrastructure version, based on the configured Version Control System (VCS) per workspace. The Terraform Working Directory specifies the location of the code to be applied.

- Changes to the `develop` branch trigger a plan for the staging workspace with modifications in the `core` module.
- Changes to the `main` branch activate the plan for the production workspace with changes in the `core` module.
- Any changes made to the `develop` or `main` branches within the `shared` folder will also trigger the plan.

Once the Terraform plan succeeds on Terraform Cloud, you can manually apply the changes to the infrastructure.

### Workspaces Configuration

Three separate workspaces need to be configured:

1. `shared`: For shared services and resources across environments.
2. `staging`: For the staging version of the application.
3. `production`: For the production version of the application.

Version control connections should be set up for each workspace. The `shared` workspace should point to the `shared` folder, and both `staging` and `production` workspaces should point to the `base` folder.

### Required Variables

All variables should be set as Terraform variables, and the 'sensitive' flag should be applied where necessary. The following variables are shared between all workspaces:

| Variable                     | Value       |
|:-----------------------------|-------------|
| AWS_ACCESS_KEY_ID            | SENSITIVE   |
| AWS_SECRET_ACCESS_KEY        | SENSITIVE   |
| bastion_allowed_ip_connection| SENSITIVE   |

These variables should be configured for `staging` and `production` workspaces. If both environments share those variables, you can set them in the [Variable Sets](https://developer.hashicorp.com/terraform/tutorials/cloud/cloud-multiple-variable-sets).

| Variable            | Value     |
|:--------------------|-----------|
| environment         | staging   |
| secret_key_base     | SENSITIVE |
| rds_username        | SENSITIVE |
| rds_password        | SENSITIVE |
| redis_auth_token    | SENSITIVE |

The following variables should be configured for the `shared` workspace:

| Variable        | Value      |
|:----------------|------------|
| environment     | production |
