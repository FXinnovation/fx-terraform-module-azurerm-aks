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
  source = "git::ssh://git@scm.dazzlingwrench.fxinnovation.com:2222/fxinnovation-public/terraform-module-azuread-service-principal.git?ref=0.1.0"

  application_name = "${random_string.default.result}aks"
}

###
# aks_cluster
###
module "aks_cluster" {
  source = "../../"

  resource_group_name                     = "${random_string.default.result}aks"
  location                                = "canadacentral"
  cluster_name                            = "${random_string.default.result}aks"
  cluster_service_principal_client_id     = "${module.aks_service_principal.client_id}"
  cluster_service_principal_client_secret = "${module.aks_service_principal.client_secret}"
  cluster_agent_pool_name                 = "${random_string.default.result}aks"
  cluster_agent_pool_count                = "1"
  cluster_agent_pool_vm_size              = "Standard_DS2_v2"
  cluster_agent_pool_vm_os_disk_gb_size   = "30"
  log_analytics_workspace_name            = "${random_string.default.result}aks"
  log_analytics_workspace_sku             = "free"
  log_analytics_workspace_retentionDays   = "30"
  cluster_rbac_enabled                    = "true"
  cluster_tags = {
    "inspec" = "true",
    "test"   = "true"
  }
}
