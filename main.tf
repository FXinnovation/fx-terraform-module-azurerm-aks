locals {
  default_ssh_public_key = "${file("~/.ssh/id_rsa.pub")}"
  ssh_public_key         = "${var.ssh_public_key != "" ? var.ssh_public_key : local.default_ssh_public_key }"
}

module "service_principal" {
  source  = "../terraform-module-azure-service_principal"
  sp_name = "${var.cluster_name}"
}

resource "azurerm_resource_group" "this_rg" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
  tags     = "${var.tags}"
}

resource "azurerm_log_analytics_workspace" "this_ws" {
  name                = "${var.log_analytics_workspace_name}"
  location            = "${var.log_analytics_workspace_location}"
  resource_group_name = "${azurerm_resource_group.this_rg.name}"
  sku                 = "${var.log_analytics_workspace_sku}"
}

resource "azurerm_log_analytics_solution" "this_ws_solution" {
  solution_name         = "ContainerInsights"
  location              = "${azurerm_log_analytics_workspace.this_ws.location}"
  resource_group_name   = "${azurerm_resource_group.this_rg.name}"
  workspace_resource_id = "${azurerm_log_analytics_workspace.this_ws.id}"
  workspace_name        = "${azurerm_log_analytics_workspace.this_ws.name}"

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}

resource "azurerm_kubernetes_cluster" "this" {
  name                = "${var.cluster_name}"
  location            = "${azurerm_resource_group.this_rg.location}"
  resource_group_name = "${azurerm_resource_group.this_rg.name}"
  dns_prefix          = "${var.cluster_name}"

  linux_profile {
    admin_username = "${var.admin_username}"

    ssh_key {
      key_data = "${local.ssh_public_key}"
    }
  }

  agent_pool_profile {
    name            = "default_agentpool"
    count           = "${var.agent_count}"
    vm_size         = "${var.vm_size}"
    os_type         = "Linux"
    os_disk_size_gb = "${var.vm_os_disk_gb_size}"
  }

  addon_profile {
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = "${azurerm_log_analytics_workspace.this_ws.id}"
    }
  }

  service_principal {
    client_id     = "${module.service_principal.client_id}"
    client_secret = "${module.service_principal.client_secret}"
  }

  tags = "${var.tags}"
}
