variable "subnet_ids" {
  description = "The public subnet IDs for the instance"
  type        = list(string)
}

variable "instance_security_group_ids" {
  description = "The security group IDs for the instance"
  type        = list(string)
}
