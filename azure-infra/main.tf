provider "azurerm" {
  features {}
}

module "k8s-infra" {
  source = "kube-champ/k8s-infra/azure"

  name        = "k8s-infra"
  environment = var.environment
  az_location = var.az_location

  public_dns_zone_enabled = true
  public_dns_zone         = "kubechamp.gq"

  private_dns_zone_enabled = true
  private_dns_zone         = "kubechamp.internal"

  vnet_address_space = "10.0.0.0/16"
  subnets = {
    snet1 = "10.0.0.0/19"
  }

  nsgs      = []
  nsg_rules = {}
}

module "aks-cluster" {
  source = "kube-champ/aks/azure"

  client_id     = var.client_id
  client_secret = var.client_secret

  name        = "demo"
  environment = var.environment
  az_location = var.az_location
  subnet_id   = module.k8s-infra.subnets["snet-${var.environment}-snet1"]

  cluster_network = {
    network_plugin     = "azure"
    network_policy     = "calico"
    service_cidr       = "10.0.192.0/18"
    docker_bridge_cidr = "172.17.0.1/16"
    dns_service_ip     = "10.0.192.100"
    load_balancer_sku  = "Standard"
  }
}
