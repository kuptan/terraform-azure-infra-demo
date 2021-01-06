## Global
key_vault_policy_object_ids = {
        "sp_main" = {
          id = "aaf08f3b-a072-42c7-8999-e89730ee14c8"
          name = "sp"
          cluster = "main"
        },
        "ibra_main" = {
          id = "06eb1509-cc1f-4aae-9de3-2fc22f72b34f"
          name = "ibra"
          cluster = "main"
        },
}

bastion_enabled = false
bastion_admin_user = "kubebastionadmin"

clusters = {
  "main" = {
      cluster_name           = "main"
      subnet_name           = "main"
      cluster_version        = "1.18.8"
      kube_dashboard_enabled = true
      private_cluster_enabled= false
      cluster_admin_user     = "mainadmin"
      cluster_network = {
        network_plugin       = "azure"
        network_policy       = "calico"
        service_cidr       = "10.100.0.0/16"
        docker_bridge_cidr = "172.17.0.1/16"
        dns_service_ip     = "10.100.0.10"
        dns_prefix         = "main-dns"
        load_balancer_sku     = "Standard"
      }
      default_node_pool = {
        name               = "d4v3"
        node_count         = 2
        vm_size            = "Standard_D4_v3"
        os_disk_size_gb    = 30
        min_count          = 1
        max_count          = 6
        availability_zones = [1]
      }
      ad_rbac_enabled       = true
      ad_admins_object_ids = [
          "06eb1509-cc1f-4aae-9de3-2fc22f72b34f",
      ]
    },
}

additional_node_pools = {
}

secret_permissions = [
    "set",
    "get",
    "list",
    "delete",
]

key_permissions = [
    "create",
    "get",
    "list",
    "delete",
]

certificate_permissions = [
    "create",
    "update",
    "get",
    "list",
    "delete",
]

storage_permissions = [
    "update",
    "get",
    "list",
    "delete",
]