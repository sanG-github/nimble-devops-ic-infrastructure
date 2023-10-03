terraform {
  cloud {
    organization = "devops-ic"

    workspaces {
      name = "staging"
    }
  }
}
