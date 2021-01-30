output "flux_private_key" {
  sensitive = true
  value     = tls_private_key.flux_key.private_key_pem
}

output "flux_public_key" {
  sensitive = true
  value     = tls_private_key.flux_key.public_key_openssh
}

output "sealed_secrets_private_key" {
  sensitive = true
  value     = tls_private_key.sealed_key.private_key_pem
}

output "sealed_secrets_public_key" {
  sensitive = true
  value     = tls_private_key.sealed_key.public_key_openssh
}

output "sealed_secrets_cert" {
  sensitive = true
  value     = tls_self_signed_cert.sealed_cert.cert_pem
}

output "thanos_grpc_ca" {
  sensitive = true
  value = tls_self_signed_cert.ca.cert_pem
}

output "thanos_grpc_cert_private_key" {
  sensitive = true
  value = tls_private_key.cert.private_key_pem
}

output "thanos_grpc_cert" {
  sensitive = true
  value = tls_locally_signed_cert.cert.cert_pem
}