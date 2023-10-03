resource "aws_iam_user" "user_account" {
  #checkov:skip=CKV_AWS_273: Allow access is controlled through AWS IAM defined users
  for_each = toset(var.usernames)

  name = each.value
  path = var.path

  force_destroy = true
}

resource "aws_iam_user_login_profile" "user_account" {
  for_each = local.user_accounts

  user = each.value.name

  lifecycle {
    ignore_changes = [
      password_reset_required,
    ]
  }
}
