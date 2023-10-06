variable "environment" {
  description = "The application environment, used to tag the resources, e.g. `acme-web-staging`"
  type        = string
  default     = "staging"
}

variable "secret_key_base" {
  description = "The secret key base for the application"
  type        = string
}

variable "app_port" {
  description = "Application running port"
  type        = number
}

variable "health_check_path" {
  description = "The health check path of the Application"
  type        = string
}
