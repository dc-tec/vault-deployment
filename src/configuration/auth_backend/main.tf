terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "4.3.0"
    }
  }
  required_version = "1.9.3"

  backend "local" {
    path = "./terraform.tfstate"
  }
}

provider "vault" {}
