module "resource_group" {
  source = "git::https://scm.dazzlingwrench.fxinnovation.com/fxinnovation-public/terraform-module-azurerm-resource-group.git?ref=1.0.0"

  enabled  = var.enabled
  name     = var.resource_group_name
  location = var.location
  tags = merge(
    var.tags,
    var.resource_group_tags
  )
}

module "log_analytics_workspace" {
  source = "git::https://scm.dazzlingwrench.fxinnovation.com/fxinnovation-public/terraform-module-azurerm-log-analytics-workspace.git?ref=1.0.0"

  enabled             = var.enabled
  name                = var.log_analytics_workspace_name
  location            = var.location
  resource_group_name = module.resource_group.name
  tags = merge(
    var.tags,
    var.log_analytics_workspace_tags
  )
}

resource "azurerm_log_analytics_solution" "this" {
  count = var.enabled ? 1 : 0

  solution_name         = "ContainerInsights"
  location              = var.location
  resource_group_name   = module.resource_group.name
  workspace_resource_id = module.log_analytics_workspace.id
  workspace_name        = var.log_analytics_workspace_name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}

module "service_principal" {
  source = "git::https://scm.dazzlingwrench.fxinnovation.com/fxinnovation-public/terraform-module-azuread-service-principal.git?ref=1.0.6"

  enabled = var.enabled

  application_name = var.name
}

resource "azurerm_kubernetes_cluster" "this" {
  count = var.enabled ? 1 : 0

  name                = var.name
  location            = var.location
  resource_group_name = module.resource_group.name
  kubernetes_version  = var.kubernetes_version
  dns_prefix          = var.dns_prefix

  dynamic "default_node_pool" {
    for_each = var.default_node_pool

    content {
      name            = default_node_pool.value.name
      vm_size         = default_node_pool.value.vm_size
      type            = default_node_pool.value.type
      node_count      = default_node_pool.value.node_count
      os_disk_size_gb = default_node_pool.value.os_disk_size_gb
    }
  }

  dynamic "linux_profile" {
    for_each = var.admin_username != "" ? [1] : []
    content {
      admin_username = var.admin_username
      ssh_key {
        key_data = var.ssh_key_key_data
      }
    }
  }

  addon_profile {
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = module.log_analytics_workspace.id
    }
  }

  service_principal {
    client_id     = module.service_principal.client_id
    client_secret = module.service_principal.client_secret
  }

  role_based_access_control {
    enabled = var.rbac_enabled
  }

  tags = merge(
    {
      "Terraform" = "true"
    },
    var.tags,
  )
}
