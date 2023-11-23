module "rds" {
  #checkov:skip=CKV_TF_1: Use specific version instead of defining the commit hash
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "8.5.0"

  name                   = local.namespace
  create_db_subnet_group = true

  engine         = local.engine
  engine_version = local.engine_version

  availability_zones     = data.aws_availability_zones.available.names
  vpc_id                 = var.vpc_id
  subnets                = var.subnet_ids
  vpc_security_group_ids = var.vpc_security_group_ids

  instance_class = var.instance_type
  instances = {
    main = {}
  }

  autoscaling_enabled      = true
  autoscaling_min_capacity = var.autoscaling_min_capacity
  autoscaling_max_capacity = var.autoscaling_max_capacity

  create_monitoring_role = var.create_monitoring_role
  create_security_group  = false
  storage_encrypted      = true

  publicly_accessible = false

  database_name       = var.database_name
  master_username     = var.username
  master_password     = var.password
  port                = var.port
  deletion_protection = true

  enabled_cloudwatch_logs_exports = var.cloudwatch_logs_exports
}
