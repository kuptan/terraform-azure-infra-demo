terraform {
  backend "azurerm" {
    resource_group_name  = "tf-storage"
    storage_account_name = "azakstfstorage"
    container_name       = "tfstate"
    key                  = "sshkeys.demo.terraform.tfstate"
  }
}

resource "tls_private_key" "flux_key" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "tls_private_key" "sealed_key" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "tls_self_signed_cert" "sealed_cert" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.sealed_key.private_key_pem

  subject {
    common_name  = var.common_name
    organization = var.organization
  }

  validity_period_hours = 12

  allowed_uses = [
    "key_encipherment",
    "data_encipherment",
    "digital_signature",
    "server_auth",
  ]
}