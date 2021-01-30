variable "common_name" {
  description = "The sealed secrets certification common name"
  type = string
}

variable "organization" {
  description = "The certification organization"
  type = string
}

variable "thanos_tls_dns_names" {
  description = "The dns names that the thanos grpc tls cert applies to"
  type = list(string)
}