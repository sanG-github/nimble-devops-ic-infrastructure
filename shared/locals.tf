locals {
  # Application name
  app_name = "nimble-devops-ic-web"

  # The application environment, used to tag the resources, e.g. `acme-web-staging`
  environment = "shared"

  # The owner of the infrastructure, used to tag the resources, e.g. `acme-web`
  owner = "sanghuynh20000"

  # AWS region
  region = "ap-southeast-1"

  # List of admin emails to provision IAM user account
  iam_admin_emails = ["sanghuynh20000@gmail.com"]

  # List of bot emails to provision IAM user account
  iam_bot_emails = ["bot@nimblehq.co"]

  # List of developer emails to provision IAM user account
  iam_developer_emails = ["sang@nimblehq.co"]
}
