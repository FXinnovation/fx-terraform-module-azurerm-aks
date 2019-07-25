module "aks_cluster" {
  source = "../../"

  resource_group_name                   = "tftest-aks"
  location                              = "canadacentral"
  name                                  = "tftest-aks"
  service_principal_client_id           = "${module.aks_service_principal.client_id}"
  service_principal_client_secret       = "${module.aks_service_principal.client_secret}"
  agent_pool_name                       = "tftest-aks"
  agent_pool_count                      = "1"
  agent_pool_vm_size                    = "Standard_DS2_v2"
  agent_pool_vm_os_disk_gb_size         = "30"
  log_analytics_workspace_name          = "tftest-aks"
  log_analytics_workspace_sku           = "free"
  log_analytics_workspace_retentionDays = 30
  rbac_enabled                          = true

  tags = {
    "inspec" = "true"
    "test"   = "true"
  }
}
