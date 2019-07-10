###
# Providers
###
provider "azurerm" {
  version         = "~> 1.28.0"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  subscription_id = "${var.subscription_id}"
  tenant_id       = "${var.tenant_id}"
}

provider "random" {
  version = "~> 2.0"
}

###
# Variables
###
variable "client_id" {
  type = "string"
}

variable "client_secret" {
  type = "string"
}

variable "subscription_id" {
  type = "string"
}

variable "tenant_id" {
  type = "string"
}

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

# module "aks_cluster" {
#   source = "../../"
#
#   resource_group_name                   = "${azurerm_resource_group.this_rg.name}"
#   location                              = "${azurerm_resource_group.this_rg.location}"
#   cluster_name                          = "${var.cluster_name}"
#   kubernetes_version                    = "${var.kubernetes_version}"
#   service_principal_client_id           = "${module.service_principal.client_id}"
#   service_principal_client_secret       = "${module.service_principal.client_secret}"
#   admin_username                        = "${var.admin_username}"
#   ssh_public_key                        = "${local.ssh_public_key}"
#   agent_count                           = "${var.agent_count}"
#   vm_size                               = "${var.vm_size}"
#   vm_os_disk_gb_size                    = "${var.vm_os_disk_gb_size}"
#   log_analytics_workspace_name          = "${var.log_analytics_workspace_name}"
#   log_analytics_workspace_sku           = "${var.log_analytics_workspace_sku}"
#   log_analytics_workspace_retentionDays = "${var.log_analytics_workspace_sku == "free" ? "" : var.log_analytics_workspace_retentionDays}"
#   rbac_enabled                          = "${var.rbac_enabled}"
#   tags                                  = "${var.tags}"
# }
