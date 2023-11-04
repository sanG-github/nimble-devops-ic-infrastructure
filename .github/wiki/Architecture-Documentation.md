This document outlines the software and hardware requirements for running the infrastructure of the [example app](https://github.com/SanG-github/nimble-devops-ic-web). You can refer to the [[Architecture Diagram]] for a visual overview of the infrastructure components.

## Required Hardware

The infrastructure is hosted on AWS and relies on various AWS services, including ECS with Fargate launch type, RDS, and ElastiCache. Migrating to a different cloud provider is possible, thanks to Terraform's flexibility.

### RDS Instance Type

- Instance Type: `db.t3.micro`

### ElastiCache Instance Type

- Instance Type: `cache.t3.micro`

### ECS Fargate Instance Type

The instance type for ECS Fargate varies and is controlled by the `ecs` variable, which is further described in this documentation.

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

| Variable                    | Value       |
|:----------------------------|-------------|
| aws_access_key              | SENSITIVE   |
| aws_secret_key              | SENSITIVE   |
| app_name                    | nimble-devops-ic-web  |
| app_port                    | 4000        |
| bastion_allowed_ip_connection | SENSITIVE |
| health_check_path           | /health     |
| owner                       | sanghuynh20000 |
| ecs                         | {<br>&nbsp;&nbsp;task_desired_count = 3 <br>&nbsp;&nbsp;web_container_cpu = 256 <br>&nbsp;&nbsp;web_container_memory = 512 <br>&nbsp;&nbsp;deployment_maximum_percent = 200 <br>&nbsp;&nbsp;deployment_minimum_healthy_percent = 50 <br>&nbsp;&nbsp;max_capacity = 10 <br>&nbsp;&nbsp;max_cpu_threshold = 80 <br>} |

These variables should be configured for `staging` and `production` workspaces. If both environments share those variables, you can set them in the [Variable Sets](https://developer.hashicorp.com/terraform/tutorials/cloud/cloud-multiple-variable-sets).

| Variable        | Value     |
|:----------------|-----------|
| environment     | staging   |
| secret_key_base | SENSITIVE |
| rds_username    | SENSITIVE |
| rds_password    | SENSITIVE |

The following variables should be configured for the `shared` workspace:

| Variable        | Value      |
|:----------------|------------|
| environment     | production |
