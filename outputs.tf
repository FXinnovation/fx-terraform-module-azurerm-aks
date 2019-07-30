output "log_analytics_workspace_id" {
  value = module.log_analytics_workspace.id
}

output "log_analytics_workspace_primary_shared_key" {
  sensitive = true
  value     = module.log_analytics_workspace.primary_shared_key
}

output "log_analytics_workspace_secondary_shared_key" {
  sensitive = true
  value     = module.log_analytics_workspace.secondary_shared_key
}

output "log_analytics_workspace_workspace_id" {
  value = module.log_analytics_workspace.workspace_id
}

output "id" {
  value = element(concat(azurerm_kubernetes_cluster.this.*.id, [""]), 0)
}

output "fqdn" {
  value = element(concat(azurerm_kubernetes_cluster.this.*.fqdn, [""]), 0)
}

output "kube_admin_config" {
  sensitive = true
  value     = element(concat(azurerm_kubernetes_cluster.this.*.kube_admin_config, [""]), 0)
}

output "kube_config" {
  sensitive = true
  value     = element(concat(azurerm_kubernetes_cluster.this.*.kube_config, [""]), 0)
}
