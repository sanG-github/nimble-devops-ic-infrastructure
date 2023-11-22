output "secrets_variables" {
  description = "The formatted secrets for Task Definition"
  value       = local.secrets_variables
}

output "secret_arns" {
  description = "The secrets ARNs for Task Definition"
  value       = local.secret_arns
}

output "secret_key_arn" {
  description = "The key to use for logs encryption"
  value       = aws_kms_key.secret_key_arn.arn
}
