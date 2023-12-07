variable "environment" {
  description = "The application environment, used to tag the resources, e.g. `acme-web-staging`"
  type        = string
}

variable "port" {
  description = "Cache node port"
  type        = number
}

variable "node_type" {
  description = "Elasticache node type"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs"
  type        = list(any)
}

variable "security_group_ids" {
  description = "One or more VPC security groups associated with the cache cluster"
  type        = list(any)
}

variable "auth_token" {
  description = "The auth token for the Redis cluster"
  type        = string
}

variable "kms_key_id" {
  description = "The ARN of the KMS key to be used to encrypt the Redis cluster"
  type        = string
}
