variable "usernames" {
  description = "Desired names for the IAM user"
  type        = list(string)
}

variable "loginable" {
  description = "Boolean for whether login is enabled"
  default     = true
}
