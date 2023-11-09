resource "aws_security_group" "alb" {
  #checkov:skip=CKV2_AWS_5: This security group is used by an ALB
  vpc_id      = var.vpc_id
  name        = local.alb_security_group_name
  description = local.alb_security_group_description

  tags = {
    Name = local.alb_security_group_name
  }
}

#tfsec:ignore:aws-ec2-no-public-ingress-sgr
resource "aws_security_group_rule" "alb_ingress_http" {
  #checkov:skip=CKV_AWS_260: Allow ingress from 0.0.0.0:0 to port 80
  security_group_id = aws_security_group.alb.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "From HTTP to ALB"
}

#tfsec:ignore:aws-ec2-no-public-egress-sgr
resource "aws_security_group_rule" "alb_egress" {
  security_group_id = aws_security_group.alb.id
  from_port         = var.app_port
  to_port           = var.app_port
  type              = "egress"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "From ALB to app"
}
