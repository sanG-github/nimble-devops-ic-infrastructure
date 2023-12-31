resource "aws_lb" "this" {
  #checkov:skip=CKV2_AWS_20: HTTP protocol is used for redirecting to HTTPS
  #checkov:skip=CKV2_AWS_28: There is no need to protect public ALB by WAF
  name               = local.namespace
  load_balancer_type = local.load_balancer_type
  subnets            = var.subnet_ids
  security_groups    = var.security_group_ids

  enable_deletion_protection = true
  drop_invalid_header_fields = true

  # tfsec:ignore:aws-elb-alb-not-public
  internal = false

  access_logs {
    bucket  = local.access_logs_bucket
    enabled = true
  }
}

resource "aws_lb_target_group" "application_target_group" {
  port                 = var.app_port
  vpc_id               = var.vpc_id
  name                 = local.application_target_group_name
  target_type          = local.application_target_type
  deregistration_delay = local.application_target_deregistration_delay
  protocol             = local.application_target_group_protocol

  health_check {
    path                = var.health_check_path
    port                = var.app_port
    timeout             = local.health_check_timeout
    interval            = local.health_check_interval
    healthy_threshold   = local.health_check_healthy_threshold
    unhealthy_threshold = local.health_check_unhealthy_threshold
    protocol            = local.health_check_protocol
    matcher             = local.health_check_matcher
  }

  dynamic "stickiness" {
    for_each = local.enable_stickiness ? [1] : []

    content {
      enabled = local.enable_stickiness
      type    = local.stickiness_type
    }
  }
}

# tfsec:ignore:aws-elb-http-not-used
resource "aws_lb_listener" "app_http" {
  load_balancer_arn = aws_lb.this.arn
  port              = local.aws_lb_listener_port

  #checkov:skip=CKV_AWS_2: HTTP protocol is used for redirecting to HTTPS
  #checkov:skip=CKV_AWS_103: HTTP protocol is used for redirecting to HTTPS, so there is no TLS certificate
  protocol = local.aws_lb_listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.application_target_group.arn
  }
}
