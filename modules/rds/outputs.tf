output "db_endpoint" {
  value = module.rds.cluster_endpoint
}

output "db_url" {
  value = "postgresql://${var.username}:${var.password}@${module.rds.cluster_endpoint}/${var.database_name}"
}
