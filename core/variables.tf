variable "environment" {
  description = "The application environment, used to tag the resources, e.g. `acme-web-staging`"
  type        = string
  default     = "staging"
}

variable "secret_key_base" {
  description = "The secret key base for the application"
  type        = string
}

variable "rds_instance_type" {
  description = "RDS instance type"
  type        = string
  default     = "db.t3.micro"
}

variable "rds_username" {
  description = "RDS username"
  type        = string
}

variable "rds_password" {
  description = "RDS password"
  type        = string
}

variable "rds_autoscaling_min_capacity" {
  description = "Minimum number of RDS read replicas when autoscaling is enabled"
  type        = number
  default     = 1
}

variable "rds_autoscaling_max_capacity" {
  description = "Maximum number of RDS read replicas when autoscaling is enabled"
  type        = number
  default     = 5
}
