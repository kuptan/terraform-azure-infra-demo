data "terraform_remote_state" "sshkeys" {
  backend = "azurerm"
  config = {
    resource_group_name  = "tf-storage"
    storage_account_name = "azakstfstorage"
    container_name       = "tfstate"
    key                  = "sshkeys.demo.terraform.tfstate"
  }
}

module "flux-bootstrap" {
  source = "kube-champ/flux-bootstrap/k8s"

  flux_ssh_scan_url = var.flux_ssh_scan_url
  git_url           = var.git_url
  flux_target_path  = var.flux_target_path

  sealed_secrets = {
    generate_key_cert = false
    private_key       = data.terraform_remote_state.sshkeys.outputs.sealed_secrets_private_key
    private_cert      = data.terraform_remote_state.sshkeys.outputs.sealed_secrets_cert
    chart_version     = "1.14.0-r1"
    docker_image_tag  = "v0.14.0"
  }

  flux_ssh_keys = {
    generate_key = false
    private_key  = data.terraform_remote_state.sshkeys.outputs.flux_private_key
    public_key   = data.terraform_remote_state.sshkeys.outputs.flux_public_key
  }
}
