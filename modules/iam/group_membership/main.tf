resource "aws_iam_group_membership" "this" {
  #checkov:skip=CKV2_AWS_14: Ensure that IAM groups includes at least one IAM user
  #checkov:skip=CKV2_AWS_21: Ensure that all IAM users are members of at least one IAM group.
  name = var.name

  group = var.group
  users = var.users
}
