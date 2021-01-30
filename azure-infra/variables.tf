variable "client_id" {
  description = "Service principal's client ID for AKS service principal configuration"
  sensitive   = true
  type        = string
}

variable "client_secret" {
  description = "Service principal's client secret for AKS service principal configuration"
  sensitive   = true
  type        = string
}

variable "environment" {
  description = "The environment name on which these resources are deployed"
  type        = string

  default = "lab"
}

variable "az_location" {
  description = "The azure location on which resources are deployed"
  type        = string

  default = "westeurope"
}

variable "clusters" {
  type = map(map(string))

  default = {
    "ops" = {
      cluster_version = "1.19.6"
      subnet          = "snet1"
      dns_service_ip  = "10.0.192.100"
    }
    # "workload-1" = {
    #   cluster_version = "1.19.6"
    #   subnet          = "snet2"
    #   dns_service_ip  = "10.0.192.101"
    # }
  }
}