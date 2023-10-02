#tfsec:ignore:aws-iam-enforce-group-mfa
resource "aws_iam_group" "admin" {
  name = "Admin-group"
  path = "/admins"
}

#tfsec:ignore:aws-iam-enforce-group-mfa
resource "aws_iam_group" "developer" {
  name = "Developer-group"
  path = "/developers"
}

#tfsec:ignore:aws-iam-enforce-group-mfa
resource "aws_iam_group" "bot" {
  name = "Bot-group"
  path = "/bots"
}

resource "aws_iam_group_policy_attachment" "admin_access" {
  group      = aws_iam_group.admin.name
  policy_arn = data.aws_iam_policy.admin_access.arn
}

resource "aws_iam_group_policy_attachment" "developer_power_user_access" {
  group      = aws_iam_group.developer.name
  policy_arn = data.aws_iam_policy.power_user_access.arn
}

resource "aws_iam_group_policy_attachment" "bot_power_user_access" {
  group      = aws_iam_group.bot.name
  policy_arn = data.aws_iam_policy.power_user_access.arn
}

