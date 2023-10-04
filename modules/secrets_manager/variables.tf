variable "secrets" {
  description = "Map of secrets to keep in AWS Secrets Manager"
  type        = map(string)
  default     = {}
}
