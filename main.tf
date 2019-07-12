resource "azurerm_resource_group" "this" {
  count    = var.enabled == "false" ? 0 : 1
  name     = var.resource_group_name
  location = var.location
  tags = merge(
    {
      "Terraform" = "true"
    },
    var.resource_group_tags,
  )
}

//resource "azurerm_log_analytics_workspace" "this_free" {
//  count               = var.enabled == "false" && var.log_analytics_workspace_sku != "free" ? 0 : 1
//  name                = var.log_analytics_workspace_name
//  location            = var.location
//  resource_group_name = azurerm_resource_group.this[0].name
//  sku                 = var.log_analytics_workspace_sku
//}
//
//resource "azurerm_log_analytics_workspace" "this_nonfree" {
//  count               = var.enabled == "false" && var.log_analytics_workspace_sku == "free" ? 0 : 1
//  name                = var.log_analytics_workspace_name
//  location            = var.location
//  resource_group_name = azurerm_resource_group.this[0].name
//  sku                 = var.log_analytics_workspace_sku
//  retention_in_days   = var.log_analytics_workspace_retentionDays
//}
//
//resource "azurerm_log_analytics_solution" "this" {
//  count                 = var.enabled == "false" ? 0 : 1
//  solution_name         = "ContainerInsights"
//  location              = var.location
//  resource_group_name   = azurerm_resource_group.this[0].name
//  workspace_resource_id = var.log_analytics_workspace_sku == "free" ? azurerm_log_analytics_workspace.this_free[0].id : azurerm_log_analytics_workspace.this_nonfree[0].id
//  workspace_name        = var.log_analytics_workspace_sku == "free" ? azurerm_log_analytics_workspace.this_free[0].name : azurerm_log_analytics_workspace.this_nonfree[0].name
//
//  plan {
//    publisher = "Microsoft"
//    product   = "OMSGallery/ContainerInsights"
//  }
//}

resource "azurerm_kubernetes_cluster" "this" {
  count               = var.enabled == "false" ? 0 : 1
  name                = var.cluster_name
  location            = azurerm_resource_group.this[0].location
  resource_group_name = azurerm_resource_group.this[0].name
  kubernetes_version  = var.cluster_kubernetes_version
  dns_prefix          = var.cluster_dns_prefix

  agent_pool_profile {
    name            = var.cluster_agent_pool_name
    count           = var.cluster_agent_pool_count
    vm_size         = var.cluster_agent_pool_vm_size
    os_type         = var.cluster_agent_pool_os_type
    os_disk_size_gb = var.cluster_agent_pool_vm_os_disk_gb_size
  }

  addon_profile {
    //oms_agent {
    //  enabled                    = true
    //  log_analytics_workspace_id = var.log_analytics_workspace_sku == "free" ? azurerm_log_analytics_workspace.this_free[0].id : azurerm_log_analytics_workspace.this_nonfree[0].id
    //}
  }

  service_principal {
    client_id     = var.cluster_service_principal_client_id
    client_secret = var.cluster_service_principal_client_secret
  }

  role_based_access_control {
    enabled = var.cluster_rbac_enabled
  }

  tags = merge(
    {
      "Terraform" = "true"
    },
    var.cluster_tags,
  )
}
