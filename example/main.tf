locals {
  default_ssh_public_key = "${file("~/.ssh/id_rsa.pub")}"
  ssh_public_key         = "${var.ssh_public_key != "" ? var.ssh_public_key : local.default_ssh_public_key }"
}

resource "azurerm_resource_group" "this_rg" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
  tags     = "${var.tags}"
}

module "service_principal" {
  source  = "../../terraform-module-azure-service_principal"
  sp_name = "${var.cluster_name}"
}

module "aks_cluster" {
  source                                = "../"
  resource_group_name                   = "${azurerm_resource_group.this_rg.name}"
  location                              = "${azurerm_resource_group.this_rg.location}"
  cluster_name                          = "${var.cluster_name}"
  kubernetes_version                    = "${var.kubernetes_version}"
  admin_username                        = "${var.admin_username}"
  ssh_public_key                        = "${var.ssh_public_key}"
  agent_count                           = "${var.agent_count}"
  vm_size                               = "${var.vm_size}"
  vm_os_disk_gb_size                    = "${var.vm_os_disk_gb_size}"
  log_analytics_workspace_name          = "${var.log_analytics_workspace_name}"
  log_analytics_workspace_sku           = "${var.log_analytics_workspace_sku}"
  log_analytics_workspace_retentionDays = "${var.log_analytics_workspace_retentionDays}"
  tags                                  = "${var.tags}"
}
