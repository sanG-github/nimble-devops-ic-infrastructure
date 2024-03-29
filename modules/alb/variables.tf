variable "environment" {
  description = "The application environment, used to tag the resources, e.g. `acme-web-staging`"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs to attach to the LB"
  type        = list(string)
}

variable "security_group_ids" {
  description = "A list of security group IDs to assign to the LB"
  type        = list(string)
}

variable "health_check_path" {
  description = "The health check path of the Application"
  type        = string
}

variable "app_port" {
  description = "Application running port"
  type        = number
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
