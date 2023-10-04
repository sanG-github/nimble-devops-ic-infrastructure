locals {
  # List of IAM users to create login profile
  user_accounts = var.loginable ? aws_iam_user.user_account : {}

  # Desired path for the IAM user
  path = "/"
}
