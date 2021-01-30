# variable "azure" {
#   description = "The azure aks config"
#   type        = object({ name : string, resource_group_name : string })
  
#   # default = {
#   #   name                = "k8s-lab-ops"
#   #   resource_group_name = "rg-lab-cluster-ops"
#   # }
# }

variable "azure_aks_name" {
  description = "The full AKS cluster name"
  type = string
}

variable "azure_aks_rg" {
  description = "The Azure resource group name"
  type = string
}

variable "flux_target_path" {
  description = "The path of the directory in the Git repository on which Flux will sync"
  type        = string

  # default = "clusters/lab/aks-demo"
}

variable "cloud_provider" {
  description = "The cloud provider name. (Only azure is supported)"
  type        = string

  default = "azure"
}

variable "git_url" {
  description = "The URL of the git repository"
  type        = string

  default = "ssh://git@github.com/kube-champ/flux-clusters.git"
}

variable "flux_ssh_scan_url" {
  description = "The domain that will be used by the ssh-keyscan. Only required when flux_auth_type is ssh"
  type        = string

  default = "github.com"
}