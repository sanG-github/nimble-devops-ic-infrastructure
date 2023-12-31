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

resource "aws_security_group" "ecs_fargate" {
  #checkov:skip=CKV2_AWS_5: This security group will be used by an ECS Fargate task
  name        = "${local.namespace}-ecs-fargate"
  description = "ECS Fargate Security Group"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${local.namespace}-ecs-fargate"
  }
}

resource "aws_security_group_rule" "ecs_fargate_ingress_alb" {
  type                     = "ingress"
  security_group_id        = aws_security_group.ecs_fargate.id
  protocol                 = "tcp"
  from_port                = var.app_port
  to_port                  = var.app_port
  source_security_group_id = aws_security_group.alb.id
  description              = "From ALB to app"
}

resource "aws_security_group_rule" "ecs_fargate_ingress_private" {
  type              = "ingress"
  security_group_id = aws_security_group.ecs_fargate.id
  protocol          = "-1"
  from_port         = 1024
  to_port           = 65535
  cidr_blocks       = var.private_subnets_cidr_blocks
  description       = "From internal VPC to app"
}

#tfsec:ignore:aws-ec2-no-public-egress-sgr
resource "aws_security_group_rule" "ecs_fargate_egress_anywhere" {
  type              = "egress"
  security_group_id = aws_security_group.ecs_fargate.id
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "From app to everywhere"
}

resource "aws_security_group" "rds" {
  #checkov:skip=CKV2_AWS_5: This security group will be used by an RDS instance
  name        = "${local.namespace}-rds"
  description = "RDS Security Group"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${local.namespace}-rds"
  }
}

resource "aws_security_group_rule" "rds_ingress_app_fargate" {
  type                     = "ingress"
  security_group_id        = aws_security_group.rds.id
  from_port                = var.rds_port
  to_port                  = var.rds_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ecs_fargate.id
  description              = "From app to DB"
}

resource "aws_security_group" "elasticache" {
  #checkov:skip=CKV2_AWS_5: This security group will be used by an Elasticache cluster
  name        = "${local.namespace}-elasticache"
  description = "Elasticache Security Group"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${local.namespace}-elasticache-sg"
  }
}

resource "aws_security_group_rule" "elasticache_ingress_app_fargate" {
  type                     = "ingress"
  security_group_id        = aws_security_group.elasticache.id
  from_port                = var.elasticache_port
  to_port                  = var.elasticache_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ecs_fargate.id
  description              = "From app to cache"
}

resource "aws_security_group" "bastion" {
  #checkov:skip=CKV2_AWS_5: This security group will be used by a bastion host
  name        = "${local.namespace}-bastion"
  description = "Bastion Security Group"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${local.namespace}-bastion"
  }
}

resource "aws_security_group_rule" "bastion_ingress_ssh" {
  for_each = var.bastion_allowed_ip_connections

  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  security_group_id = aws_security_group.bastion.id
  cidr_blocks       = ["${each.value}/32"]
  description       = "Allowed IP connection"
}

resource "aws_security_group_rule" "elasticache_ingress_bastion" {
  type                     = "ingress"
  security_group_id        = aws_security_group.elasticache.id
  from_port                = var.elasticache_port
  to_port                  = var.elasticache_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion.id
  description              = "From bastion to ElastiCache"
}

resource "aws_security_group_rule" "bastion_egress_elasticache" {
  type                     = "egress"
  security_group_id        = aws_security_group.bastion.id
  from_port                = var.elasticache_port
  to_port                  = var.elasticache_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.elasticache.id
  description              = "From ElastiCache to bastion"
}

resource "aws_security_group_rule" "rds_ingress_bastion" {
  type                     = "ingress"
  security_group_id        = aws_security_group.rds.id
  from_port                = var.rds_port
  to_port                  = var.rds_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion.id
  description              = "From bastion to RDS"
}

resource "aws_security_group_rule" "bastion_egress_rds" {
  type                     = "egress"
  security_group_id        = aws_security_group.bastion.id
  from_port                = var.rds_port
  to_port                  = var.rds_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.rds.id
  description              = "From RDS to bastion"
}
