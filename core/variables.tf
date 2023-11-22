variable "environment" {
  description = "The application environment, used to tag the resources, e.g. `acme-web-staging`"
  type        = string
  default     = "staging"
}

variable "secret_key_base" {
  description = "The secret key base for the application"
  type        = string
  sensitive   = true
}

variable "rds_username" {
  description = "RDS username"
  type        = string
  sensitive   = true
}

variable "rds_password" {
  description = "RDS password"
  type        = string
  sensitive   = true
}

variable "redis_auth_token" {
  description = "The auth token for the Redis cluster"
  type        = string
}

variable "bastion_allowed_ip_connection" {
  description = "IP that can be connected to Bastion instance"
  type        = string
}
