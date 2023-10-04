terraform {
  cloud {
    organization = "devops-ic"

    workspaces {
      tags = ["aws-infrastructure"]
    }
  }
}
