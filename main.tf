resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
  tags = merge(
    {
      "Terraform" = "true"
    },
    var.resource_group_tags,
  )
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = var.log_analytics_workspace_name
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = var.log_analytics_workspace_sku
  retention_in_days   = var.log_analytics_workspace_sku == "free" ? "" : var.log_analytics_workspace_retentionDays
}

resource "azurerm_log_analytics_solution" "this" {
  solution_name         = "ContainerInsights"
  location              = var.location
  resource_group_name   = azurerm_resource_group.this.name
  workspace_resource_id = azurerm_log_analytics_workspace.this.id
  workspace_name        = azurerm_log_analytics_workspace.this.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}

resource "azurerm_kubernetes_cluster" "this" {
  name                = var.aks_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  kubernetes_version  = var.aks_kubernetes_version
  dns_prefix          = var.aks_dns_prefix

  agent_pool_profile {
    name            = var.aks_agent_pool_name
    count           = var.aks_agent_pool_count
    vm_size         = var.aks_agent_pool_vm_size
    os_type         = var.aks_agent_pool_os_type
    os_disk_size_gb = var.aks_agent_pool_vm_os_disk_gb_size
  }

  addon_profile {
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.this_ws.id
    }
  }

  service_principal {
    client_id     = var.aks_service_principal_client_id
    client_secret = var.aks_service_principal_client_secret
  }

  role_based_access_control {
    enabled = var.aks_rbac_enabled
  }

  tags = merge(
    {
      "Terraform" = "true"
    },
    var.aks_tags,
  )
}
