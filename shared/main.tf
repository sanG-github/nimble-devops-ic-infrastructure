terraform {
  cloud {
    organization = "devops-ic"

    workspaces {
      name = "shared"
    }
  }
}

module "ecr" {
  source = "../modules/ecr"
}

module "iam_groups" {
  source = "../modules/iam/groups"
}

module "iam_admin_users" {
  source = "../modules/iam/users"

  usernames = local.iam_admin_emails
}

module "iam_developer_users" {
  source = "../modules/iam/users"

  usernames = local.iam_developer_emails
}

module "iam_bot_users" {
  source = "../modules/iam/users"

  usernames = local.iam_bot_emails
}

module "iam_admin_group_membership" {
  source = "../modules/iam/group_membership"

  name  = "admin-group-membership"
  group = module.iam_groups.admin_group
  users = local.iam_admin_emails
}

module "iam_developer_group_membership" {
  source = "../modules/iam/group_membership"

  name  = "developer-group-membership"
  group = module.iam_groups.developer_group
  users = local.iam_developer_emails
}

module "iam_bot_group_membership" {
  source = "../modules/iam/group_membership"

  name  = "bot-group-membership"
  group = module.iam_groups.bot_group
  users = local.iam_bot_emails
}
