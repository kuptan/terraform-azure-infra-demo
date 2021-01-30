output "namespace" {
  value = module.flux-bootstrap.namespace
}

output "flux_public_key" {
  sensitive = true
  value     = data.terraform_remote_state.sshkeys.outputs.flux_public_key
}

output "sealed_secrets_cert" {
  sensitive = true
  value     = data.terraform_remote_state.sshkeys.outputs.sealed_secrets_cert
}
