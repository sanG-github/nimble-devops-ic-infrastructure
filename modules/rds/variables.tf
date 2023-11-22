variable "database_name" {
  description = "The DB name"
  type        = string
}

variable "username" {
  description = "The DB master username"
  type        = string
}

variable "password" {
  description = "The DB master password"
  type        = string
}

variable "port" {
  description = "The DB port"
  type        = number
}

variable "instance_type" {
  description = "The Aurora DB instance type"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to assign to the DB"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs for DB subnet group"
  type        = list(string)
}

variable "autoscaling_min_capacity" {
  description = "Minimum number of read replicas when autoscaling is enabled"
  default     = 1
}

variable "autoscaling_max_capacity" {
  description = "Maximum number of read replicas when autoscaling is enabled"
  default     = 3
}

variable "create_monitoring_role" {
  description = "A flag whether to create the IAM role for monitoring"
  type        = bool
  default     = false
}

variable "cloudwatch_logs_exports" {
  description = "A list of log types to export to CloudWatch"
  type        = list(string)
  default     = ["postgresql"]
}
