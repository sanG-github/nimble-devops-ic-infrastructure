variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "app_port" {
  description = "Application running port"
  type        = number
}

variable "private_subnets_cidr_blocks" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
}

variable "rds_port" {
  description = "RDS port"
  type        = number
}

variable "elasticache_port" {
  description = "The cache node port"
  type        = number
}

variable "bastion_allowed_ip_connection" {
  description = "IP that can be connected to Bastion instance"
  type        = string
}
