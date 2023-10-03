data "aws_iam_policy" "admin_access" {
  #checkov:skip=CKV_AWS_275: Admin accounts require admin access
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

data "aws_iam_policy" "power_user_access" {
  arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}
