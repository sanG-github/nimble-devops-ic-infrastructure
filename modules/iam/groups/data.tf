data "aws_iam_policy" "admin_access" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

data "aws_iam_policy" "power_user_access" {
  arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}
