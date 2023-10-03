#checkov:skip=CKV2_AWS_21,CKV2_AWS_14
resource "aws_iam_group_membership" "this" {
  name = var.name

  group = var.group
  users = var.users
}
