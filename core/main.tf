terraform {
  cloud {
    organization = "devops-ic"

    workspaces {
      tags = ["aws-infrastructure"]
    }
  }
}

module "secrets_manager" {
  source = "../modules/secrets_manager"

  secrets = {
    secret_key_base = var.secret_key_base
  }
}

module "vpc" {
  source = "../modules/vpc"
}
