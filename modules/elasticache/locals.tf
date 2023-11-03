locals {
  namespace = "devops-ic-elasticache"

  engine                     = "redis"
  engine_version             = "6.x"
  parameter_group_name       = "default.redis6.x"
  node_type                  = "cache.t2.micro"
  number_cache_clusters      = 1
  automatic_failover_enabled = false
  at_rest_encryption_enabled = false
}
