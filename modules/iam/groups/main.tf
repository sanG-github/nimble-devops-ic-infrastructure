#tfsec:ignore:aws-iam-enforce-group-mfa
resource "aws_iam_group" "admin" {
  name = "Admin-group"
}

#tfsec:ignore:aws-iam-enforce-group-mfa
resource "aws_iam_group" "developer" {
  name = "Developer-group"
}

#tfsec:ignore:aws-iam-enforce-group-mfa
resource "aws_iam_group" "bot" {
  name = "Bot-group"
}

resource "aws_iam_group_policy_attachment" "admin_access" {
  group = aws_iam_group.admin.name

  #checkov:skip=CKV_AWS_274: Admin accounts require admin access
  policy_arn = data.aws_iam_policy.admin_access.arn
}

resource "aws_iam_group_policy_attachment" "developer_power_user_access" {
  group      = aws_iam_group.developer.name
  policy_arn = data.aws_iam_policy.power_user_access.arn
}

resource "aws_iam_group_policy" "developer_allow_manage_own_credentials" {
  group = aws_iam_group.developer.name

  #checkov:skip=CKV_AWS_355: Allow users to manage their own credentials
  #tfsec:ignore:aws-iam-no-policy-wildcards
  policy = local.allow_manage_own_credentials
}

resource "aws_iam_group_policy_attachment" "bot_power_user_access" {
  group      = aws_iam_group.bot.name
  policy_arn = data.aws_iam_policy.power_user_access.arn
}

resource "aws_iam_group_policy" "bot_full_iam_access" {
  group = aws_iam_group.bot.name

  #checkov:skip=CKV2_AWS_40: Allow bot full IAM privileges
  #tfsec:ignore:aws-iam-no-policy-wildcards
  policy = local.full_iam_access_policy
}
