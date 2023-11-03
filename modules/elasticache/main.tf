resource "aws_elasticache_subnet_group" "this" {
  name       = "${local.namespace}-subnet-group"
  subnet_ids = var.subnet_ids
}

# tfsec:ignore:aws-elasticache-enable-in-transit-encryption tfsec:ignore:aws-elasticache-enable-at-rest-encryption
resource "aws_elasticache_replication_group" "this" {
  replication_group_id = "${local.namespace}-rep-group"
  description          = "${local.namespace} rep-group"

  subnet_group_name  = aws_elasticache_subnet_group.this.name
  security_group_ids = var.security_group_ids

  port           = var.port
  node_type      = local.node_type
  engine         = local.engine
  engine_version = local.engine_version
  auth_token     = var.auth_token

  parameter_group_name        = local.parameter_group_name
  num_cache_clusters          = local.number_cache_clusters
  at_rest_encryption_enabled  = local.at_rest_encryption_enabled
  transit_encryption_enabled  = local.transit_encryption_enabled
  automatic_failover_enabled  = local.automatic_failover_enabled
  preferred_cache_cluster_azs = local.preferred_cache_cluster_azs

  kms_key_id = var.kms_key_id
}
