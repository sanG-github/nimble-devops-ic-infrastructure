variable "environment" {
  description = "The application environment, used to tag the resources, e.g. `acme-web-staging`"
  type        = string
}

variable "secrets" {
  description = "Map of secrets to keep in AWS Secrets Manager"
  type        = map(string)
  default     = {}
}
