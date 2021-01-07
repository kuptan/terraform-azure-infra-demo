terraform {
  backend "azurerm" {
    resource_group_name  = "tf-storage"
    storage_account_name = "azakstfstorage"
    container_name       = "tfstate"
    key                  = "infra.demo.terraform.tfstate"
  }
}