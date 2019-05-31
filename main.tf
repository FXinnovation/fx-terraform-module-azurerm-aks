locals {
  default_ssh_public_key = "${file("~/.ssh/id_rsa.pub")}"
  ssh_public_key         = "${var.ssh_public_key != "" ? var.ssh_public_key : local.default_ssh_public_key }"
}

resource "azurerm_resource_group" "this_rg" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
  tags     = "${var.tags}"
}

resource "azurerm_log_analytics_workspace" "this_ws" {
  name                = "${var.log_analytics_workspace_name}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.this_rg.name}"
  sku                 = "${var.log_analytics_workspace_sku}"
  retention_in_days   = "${var.log_analytics_workspace_sku == "free" ? "" : var.log_analytics_workspace_retentionDays}"
}

resource "azurerm_log_analytics_solution" "this_ws_solution" {
  solution_name         = "ContainerInsights"
  location              = "${var.location}"
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
  kubernetes_version  = "${var.kubernetes_version}"
  dns_prefix          = "${var.cluster_name}"

  linux_profile {
    admin_username = "${var.admin_username}"

    ssh_key {
      key_data = "${local.ssh_public_key}"
    }
  }

  agent_pool_profile {
    name            = "default"
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
    client_id     = "${var.service_principal_client_id}"
    client_secret = "${var.service_principal_client_secret}"
  }

  role_based_access_control {
    enabled = "${var.rbac_enabled}"
  }

  tags = "${var.tags}"
}