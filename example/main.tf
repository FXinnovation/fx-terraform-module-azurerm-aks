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
  source = "../"
  resource_group_name = "${azurerm_resource_group.this_rg.name}"
  location = "${azurerm_resource_group.this_rg.location}"
  cluster_name = "aksname"
  kubernetes_version = "1.13.5"
  admin_username = "ubuntu"
  ssh_public_key = ""
  agent_count = 3
  vm_size = "Standard_DS2_v2"
  vm_os_disk_gb_size = 40
  log_analytics_workspace_name = "fxloganalytics"
  log_analytics_workspace_sku = "free"
  log_analytics_workspace_retentionDays = 40
  tags = {
    FXOwner      = "Name2"
    FXDepartment = "cloud2"
    FXProject    = "FXCL"
  }
}
