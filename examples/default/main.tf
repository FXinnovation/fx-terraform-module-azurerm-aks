resource "azurerm_resource_group" "this_rg" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
  tags     = "${var.tags}"
}

module "service_principal" {
  source = "../../terraform-module-azure-service_principal"

  sp_name = "${var.cluster_name}"
}

module "aks_cluster" {
  source = "../../"

  resource_group_name                   = "${azurerm_resource_group.this_rg.name}"
  location                              = "${azurerm_resource_group.this_rg.location}"
  cluster_name                          = "${var.cluster_name}"
  kubernetes_version                    = "${var.kubernetes_version}"
  service_principal_client_id           = "${module.service_principal.client_id}"
  service_principal_client_secret       = "${module.service_principal.client_secret}"
  admin_username                        = "${var.admin_username}"
  ssh_public_key                        = "${local.ssh_public_key}"
  agent_count                           = "${var.agent_count}"
  vm_size                               = "${var.vm_size}"
  vm_os_disk_gb_size                    = "${var.vm_os_disk_gb_size}"
  log_analytics_workspace_name          = "${var.log_analytics_workspace_name}"
  log_analytics_workspace_sku           = "${var.log_analytics_workspace_sku}"
  log_analytics_workspace_retentionDays = "${var.log_analytics_workspace_sku == "free" ? "" : var.log_analytics_workspace_retentionDays}"
  rbac_enabled                          = "${var.rbac_enabled}"
  tags                                  = "${var.tags}"
}
