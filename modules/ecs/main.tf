
# Task execution role
resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${local.namespace}-ecs-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

#tfsec:ignore:aws-iam-no-policy-wildcards
resource "aws_iam_policy" "ecs_task_execution_kms" {
  policy = jsonencode(local.ecs_task_execution_kms_policy)
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_kms_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_task_execution_kms.arn
}

resource "aws_iam_policy" "ecs_task_execution_secrets_manager" {
  policy = jsonencode(local.ecs_task_execution_secrets_manager_policy)
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_secrets_manager_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_task_execution_secrets_manager.arn
}

# Task role
resource "aws_iam_role" "ecs_task_role" {
  name               = "${local.namespace}-ecs-task-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role.json
}

resource "aws_ecs_cluster" "this" {
  name = "${local.namespace}-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "this" {
  family                   = "${local.namespace}-service"
  cpu                      = var.web_container_cpu
  memory                   = var.web_container_memory
  network_mode             = "awsvpc"
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = local.container_definitions
  requires_compatibilities = ["FARGATE"]
}

resource "aws_ecs_service" "this" {
  name                               = "${local.namespace}-ecs-service"
  cluster                            = aws_ecs_cluster.this.id
  launch_type                        = "FARGATE"
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  desired_count                      = var.task_desired_count
  task_definition                    = "${aws_ecs_task_definition.this.family}:${max(aws_ecs_task_definition.this.revision, data.aws_ecs_task_definition.task.revision)}"

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  network_configuration {
    subnets         = var.subnets
    security_groups = var.security_groups
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_port   = var.app_port
    container_name   = local.namespace
  }
}

resource "aws_appautoscaling_target" "this" {
  max_capacity       = var.max_capacity
  min_capacity       = var.task_desired_count
  resource_id        = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.this.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "this" {
  name               = "${local.namespace}-autoscaling-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.this.resource_id
  scalable_dimension = aws_appautoscaling_target.this.scalable_dimension
  service_namespace  = aws_appautoscaling_target.this.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.max_cpu_threshold

    scale_in_cooldown  = 300
    scale_out_cooldown = 300

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}
