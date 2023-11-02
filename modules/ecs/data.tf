data "aws_ecr_repository" "repo" {
  name = var.ecr_repo_name
}

data "aws_ecs_task_definition" "task" {
  task_definition = aws_ecs_task_definition.this.family
}

data "aws_iam_policy_document" "ecs_task_execution_role" {
  version = "2012-10-17"
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}
