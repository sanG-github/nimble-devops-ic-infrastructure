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
