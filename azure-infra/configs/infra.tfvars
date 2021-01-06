## Global
## DNS
public_dns_zone_enabled = "true"
public_dns_zone = "kubechamp.gq"

private_dns_zone_enabled = "true"
private_dns_zone = "kubechamp.internal"

## Network
vnet_address_space = "10.0.0.0/8"

subnets = {
  "main" = "10.1.0.0/16",
  "bastion" = "10.120.20.0/24",
}

nsgs = [
    "bastion",
]

nsg_rules = {
}
