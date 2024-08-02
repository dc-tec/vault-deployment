terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.6"
    }
  }

  required_version = "1.8.5"

  # INFO: For development purposes, needs to move to remote backend.
  backend "local" {
    path = "terraform.tfstate"
  }
}
