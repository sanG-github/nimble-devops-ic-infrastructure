variable "region" {
  description = "AWS region"
  type        = string
}

variable "app_port" {
  description = "Application running port"
  type        = number
}

variable "ecr_repo_name" {
  description = "ECR repo name"
  type        = string
}

variable "subnets" {
  description = "Subnet where ECS placed"
  type        = list(string)
}

variable "security_groups" {
  description = "One or more VPC security groups associated with ECS cluster"
  type        = list(string)
}

variable "alb_target_group_arn" {
  description = "ALB target group ARN"
}


variable "secrets_variables" {
  description = "List of [{name = \"\", valueFrom = \"\"}] pairs of secret variables"
  type        = list(any)
}

variable "secret_arns" {
  description = "The secrets ARNs for Task Definition"
  type        = list(string)
}

variable "health_check_path" {
  description = "Application health check path"
  type        = string
}

variable "aws_cloudwatch_log_group_name" {
  description = "AWS CloudWatch Log Group name"
  type        = string
}
