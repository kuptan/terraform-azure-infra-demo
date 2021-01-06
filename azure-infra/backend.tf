terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "kubechamp"

    workspaces {
      name = "azure-aks-infra"
    }
  }
}