module "resource_group" {
  source = "git::https://git@scm.dazzlingwrench.fxinnovation.com/fxinnovation-public/terraform-module-azurerm-resource-group.git?ref=0.1.0"

  enabled  = var.enabled
  name     = var.resource_group_name
  location = var.location
  tags = merge(
    var.tags,
    var.resource_group_tags
  )
}

module "log_analytics_workspace" {
  source = "git::https://git@scm.dazzlingwrench.fxinnovation.com/fxinnovation-public/terraform-module-azurerm-log-analytics-workspace.git?ref=0.1.0"

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
  source = "git::https://git@scm.dazzlingwrench.fxinnovation.com/fxinnovation-public/terraform-module-azuread-service-principal.git?ref=1.0.5"

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

  dynamic "agent_pool_profile" {
    for_each = var.agent_pool_profiles

    content {
      name            = agent_pool_profile.value.name
      count           = agent_pool_profile.value.count
      vm_size         = agent_pool_profile.value.vm_size
      os_type         = agent_pool_profile.value.os_type
      os_disk_size_gb = agent_pool_profile.value.os_disk_size_gb
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
