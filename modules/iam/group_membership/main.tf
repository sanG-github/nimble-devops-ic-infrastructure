resource "aws_iam_group_membership" "this" {
  name = var.name

  group = var.group
  users = var.users
}
