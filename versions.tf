terraform {
  cloud {
    organization = "jkauze"

    workspaces {
      name = "Lattice_Test"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}
