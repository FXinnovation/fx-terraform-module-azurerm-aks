###
# Random Name
###
resource "random_string" "default" {
  length  = 5
  upper   = false
  special = false
}

###
# Service Principal
###
module "aks_service_principal" {
  source = "git::ssh://git@scm.dazzlingwrench.fxinnovation.com:2222/fxinnovation-public/terraform-module-azuread-service-principal.git?ref=SL-455"

  application_name = "${random_string.default.result}-aks"
}

###
# aks_cluster
###
module "aks_cluster" {
  source = "../../"

  resource_group_name                   = "${random_string.default.result}-aks"
  location                              = "canadacentral"
  cluster_name                          = "${random_string.default.result}-aks"
  kubernetes_version                    = "1.13.5"
  service_principal_client_id           = "${module.aks_service_principal.client_id}"
  service_principal_client_secret       = "${module.aks_service_principal.client_secret}"
  agent_count                           = "1"
  vm_size                               = "Standard_DS2_v2"
  vm_os_disk_gb_size                    = "30"
  log_analytics_workspace_name          = "${random_string.default.result}-aks"
  log_analytics_workspace_sku           = "free"
  log_analytics_workspace_retentionDays = "free"
  rbac_enabled                          = "true"
  tags = {
    "inspec" = "true",
    "test"   = "true"
  }
}
