terraform {
  required_providers {
    civo = {
      source = "civo/civo"
      version = "0.9.23"
    }
  }
}
provider "civo" {
  token = var.civo_token
}
