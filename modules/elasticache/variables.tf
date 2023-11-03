variable "port" {
  description = "Cache node port"
  type        = number
}

variable "subnet_ids" {
  description = "Subnet IDs"
  type        = list(any)
}

variable "security_group_ids" {
  description = "One or more VPC security groups associated with the cache cluster"
  type        = list(any)
}
