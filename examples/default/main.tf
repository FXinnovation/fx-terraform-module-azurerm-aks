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
# module "aks_cluster" {
#   source = "../../"
#
#   resource_group_name                   = "${random_string.default.result}-aks"
#   location                              = "${azurerm_resource_group.this_rg.location}"
#   cluster_name                          = "${random_string.default.result}-aks"
#   kubernetes_version                    = "${var.kubernetes_version}"
#   service_principal_client_id           = "${module.service_principal.client_id}"
#   service_principal_client_secret       = "${module.service_principal.client_secret}"
#   admin_username                        = "${var.admin_username}"
#   agent_count                           = "1"
#   vm_size                               = "${var.vm_size}"
#   vm_os_disk_gb_size                    = "100"
#   log_analytics_workspace_name          = "${random_string.default.result}-aks"
#   log_analytics_workspace_sku           = "${var.log_analytics_workspace_sku}"
#   log_analytics_workspace_retentionDays = "free"
#   rbac_enabled                          = "true"
#   tags                                  = {
#      "inspec" = "true",
#      "test"   = "true"
#    }
# }
