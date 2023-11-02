variable "environment" {
  description = "The application environment, used to tag the resources, e.g. `acme-web-staging`"
  type        = string
  default     = "staging"
}

variable "secret_key_base" {
  description = "The secret key base for the application"
  type        = string
}

variable "ecs" {
  description = "ECS input variables"

  type = object({
    task_desired_count                 = number
    web_container_cpu                  = number
    web_container_memory               = number
    deployment_maximum_percent         = number
    deployment_minimum_healthy_percent = number
    max_capacity                       = number
    max_cpu_threshold                  = number
  })
}
