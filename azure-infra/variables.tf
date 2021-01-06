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