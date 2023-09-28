terraform {
  cloud {
    organization = "devops-ic"

    workspaces {
      name = "nimble-devops-ic-infrastructure"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key

  default_tags {
    tags = {
      Environment = var.environment
      Owner       = var.owner
    }
  }
}
