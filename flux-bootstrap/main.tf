data "terraform_remote_state" "infra" {
  backend = "remote"

  config = {
    organization = "kubechamp"

    workspaces = {
      name = "azure-aks-infra"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = var.kube_config_path
  }
}

provider "kubernetes" {
  config_path      = var.kube_config_path
  # config_context   = "demo-cluster-admin"
}

module "flux-bootstrap" {
  source  = "kube-champ/flux-bootstrap/k8s"

  flux_ssh_scan_url = var.flux_ssh_scan_url
  git_url           = var.git_url
  flux_target_path  = var.flux_target_path
}