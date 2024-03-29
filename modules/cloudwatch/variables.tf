variable "environment" {
  description = "The application environment, used to tag the resources, e.g. `acme-web-staging`"
  type        = string
}

variable "kms_key_id" {
  description = "The KMS key ID to use for encryption"
  type        = string
}
