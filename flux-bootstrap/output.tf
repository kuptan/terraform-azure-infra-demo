output "namespace" {
  value = module.flux-bootstrap.namespace
}

output "flux_public_key" {
  sensitive = true
  value     = module.flux-bootstrap.flux_public_key
}

output "sealed_secrets_generated_cert" {
  sensitive = true
  value     =  module.flux-bootstrap.sealed_secrets_generated_cert
}
