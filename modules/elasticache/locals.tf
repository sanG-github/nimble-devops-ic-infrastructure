locals {
  namespace = "devops-ic-elasticache"

  engine                      = "redis"
  engine_version              = "6.x"
  parameter_group_name        = "default.redis6.x"
  node_type                   = "cache.t2.micro"
  preferred_cache_cluster_azs = ["ap-southeast-1a", "ap-southeast-1b"]
  number_cache_clusters       = 2
  automatic_failover_enabled  = true
  at_rest_encryption_enabled  = true
  transit_encryption_enabled  = true
}
