variable "provider" {
  description = "The cloud provider name. (Only azure is supported)"
  type        = string

  default = "azure"
}

variable "git_url" {
  description = "The URL of the git repository"
  type        = string

  default = "ssh://git@github.com/kube-champ/flux-clusters.git"
}

variable "flux_target_path" {
  description = "The path of the directory in the Git repository on which Flux will sync"
  type        = string

  default = "clusters/lab/aks-demo"
}

variable "flux_ssh_scan_url" {
  description = "The domain that will be used by the ssh-keyscan. Only required when flux_auth_type is ssh"
  type        = string

  default = "github.com"
}