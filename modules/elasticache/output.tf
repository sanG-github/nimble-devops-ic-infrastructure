output "redis_primary_endpoint" {
  description = "Redis primary endpoint"
  value       = "redis://${aws_elasticache_replication_group.this.primary_endpoint_address}:${var.port}"
}
