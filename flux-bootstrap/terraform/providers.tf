terraform {
  required_version = ">= 0.13"

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = var.azure_aks_name
  resource_group_name = var.azure_aks_rg
}

locals {
  providers = {
    azure = {
      host                   = var.cloud_provider == "azure" ? data.azurerm_kubernetes_cluster.aks.kube_config.0.host : ""
      cluster_ca_certificate = var.cloud_provider == "azure" ? base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate) : ""
      client_certificate     = var.cloud_provider == "azure" ? base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate) : ""
      client_key             = var.cloud_provider == "azure" ? base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.client_key) : ""
    }

    aws = {
      host                   = ""
      cluster_ca_certificate = ""
      client_certificate     = ""
      client_key             = ""
    }
  }
}

provider "helm" {
  kubernetes {
    host = local.providers[var.cloud_provider].host

    cluster_ca_certificate = local.providers[var.cloud_provider].cluster_ca_certificate
    client_certificate     = local.providers[var.cloud_provider].client_certificate
    client_key             = local.providers[var.cloud_provider].client_key
  }
}

provider "kubernetes" {
  host = local.providers[var.cloud_provider].host

  cluster_ca_certificate = local.providers[var.cloud_provider].cluster_ca_certificate
  client_certificate     = local.providers[var.cloud_provider].client_certificate
  client_key             = local.providers[var.cloud_provider].client_key
}

provider "kubectl" {
  load_config_file = false
  host = local.providers[var.cloud_provider].host

  cluster_ca_certificate = local.providers[var.cloud_provider].cluster_ca_certificate
  client_certificate     = local.providers[var.cloud_provider].client_certificate
  client_key             = local.providers[var.cloud_provider].client_key
}
