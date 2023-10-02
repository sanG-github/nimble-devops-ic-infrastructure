locals {
  user_accounts = var.loginable ? aws_iam_user.user_account : {}
}