locals {
  namespace                      = "${var.environment}-devops-ic-sg"
  alb_security_group_name        = "${var.environment}-devops-ic-alb-sg"
  alb_security_group_description = "Security group for the ALB"
}
