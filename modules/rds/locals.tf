locals {
  namespace = "${var.environment}-devops-ic-aurora-db"

  engine         = "aurora-postgresql"
  engine_version = "15.2"
}
