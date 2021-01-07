output "private_key" {
  sensitive = true
  value     = tls_private_key.key.private_key_pem
}

output "public_key" {
  sensitive = true
  value     = tls_private_key.key.public_key_openssh
}

output "cert_private_key" {
  sensitive = true
  value     = tls_private_key.cert.private_key_pem
}

output "cert" {
  sensitive = true
  value     = tls_self_signed_cert.cert.cert_pem
}
