locals {
  # Application name
  app_name = "nimble-devops-ic-web"

  # The application environment, used to tag the resources, e.g. `acme-web-staging`
  environment = "staging"

  # The owner of the infrastructure, used to tag the resources, e.g. `acme-web`
  owner = "sanghuynh20000"

  # AWS region
  region = "ap-southeast-1"
}
