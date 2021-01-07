output "host" {
  value = module.aks-cluster.host
}

output "cluster_ca_certificate" {
  sensitive = true
  value     = module.aks-cluster.cluster_ca_certificate
}

output "client_certificate" {
  sensitive = true
  value     = module.aks-cluster.client_certificate
}

output "client_key" {
  sensitive = true
  value     = module.aks-cluster.client_key
}

output "token" {
  sensitive = true
  value     = module.aks-cluster.token
}