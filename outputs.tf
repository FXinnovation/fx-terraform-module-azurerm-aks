output "host" {
  value = azurerm_kubernetes_cluster.this[0].kube_config[0].host
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.this[0].kube_config_raw
}

//output "log_analytics_workspace_id" {
//  value = var.log_analytics_workspace_sku == "free" ? azurerm_log_analytics_workspace.this_free[0].id : azurerm_log_analytics_workspace.this_nonfree[0].id
//}
