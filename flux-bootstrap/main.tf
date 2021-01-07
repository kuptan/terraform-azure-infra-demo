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
    host = data.terraform_remote_state.infra.outputs.host

    cluster_ca_certificate = base64decode(data.terraform_remote_state.infra.outputs.cluster_ca_certificate)
    client_certificate     = base64decode(data.terraform_remote_state.infra.outputs.client_certificate)
    client_key             = base64decode(data.terraform_remote_state.infra.outputs.client_key)
  }
}

provider "kubernetes" {
  load_config_file = "false"

  host = data.terraform_remote_state.infra.outputs.host

  cluster_ca_certificate = base64decode(data.terraform_remote_state.infra.outputs.cluster_ca_certificate)
  client_certificate     = base64decode(data.terraform_remote_state.infra.outputs.client_certificate)
  client_key             = base64decode(data.terraform_remote_state.infra.outputs.client_key)
}

provider "kubectl" {
  host                   = data.terraform_remote_state.infra.outputs.host
  cluster_ca_certificate = base64decode(data.terraform_remote_state.infra.outputs.cluster_ca_certificate)
  token                  = data.terraform_remote_state.infra.outputs.token
  load_config_file       = false
}

module "flux-bootstrap" {
  source  = "kube-champ/flux-bootstrap/k8s"

  flux_ssh_scan_url = var.flux_ssh_scan_url
  git_url           = var.git_url
  flux_target_path  = var.flux_target_path
}