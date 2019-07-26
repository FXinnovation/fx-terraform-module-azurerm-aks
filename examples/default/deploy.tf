module "aks_cluster" {
  source = "../../"

  resource_group_name                   = "tftest-aks"
  location                              = "canadacentral"
  name                                  = "tftest-aks"
  kubernetes_version                    = "1.13.5"
  dns_prefix                            = "kubernetes"
  log_analytics_workspace_name          = "tftest-aks"
  log_analytics_workspace_sku           = "free"
  log_analytics_workspace_retentionDays = 30
  rbac_enabled                          = true
  agent_pool_profiles = [
    {
      name            = "tftestaks"
      count           = 1
      vm_size         = "Standard_D2_v2"
      os_type         = "Linux"
      os_disk_size_gb = 30
    }
  ]

  tags = {
    "inspec" = "true"
    "test"   = "true"
  }
}
