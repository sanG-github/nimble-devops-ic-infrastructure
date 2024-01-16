locals {
  # aws_lb
  namespace                     = "${var.environment}-devops-ic-alb"
  access_logs_bucket            = "${local.namespace}-log-bucket"
  application_target_group_name = "${local.namespace}-app-tg"
  load_balancer_type            = "application"

  # aws_lb_target_group
  application_target_group_protocol       = "HTTP"
  application_target_type                 = "ip"
  application_target_deregistration_delay = 100

  # Health check timeout must be smaller than the interval
  health_check_timeout             = 20
  health_check_interval            = 30
  health_check_healthy_threshold   = 3
  health_check_unhealthy_threshold = 3
  health_check_protocol            = "HTTP"
  health_check_matcher             = "200-299"

  # stickiness
  enable_stickiness = false
  stickiness_type   = "lb_cookie"

  # aws_lb_listener
  aws_lb_listener_port     = 80
  aws_lb_listener_protocol = "HTTP"
}
