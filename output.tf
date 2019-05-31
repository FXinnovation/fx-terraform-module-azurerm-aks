output "host" {
  value = "${azurerm_kubernetes_cluster.this_noRBAC.kube_config.0.host}"
}

output "kube_config" {
  value = "${azurerm_kubernetes_cluster.this.kube_config_raw}"
}

output "log_analytics_workspace_id" {
  value = "${azurerm_log_analytics_workspace.this_ws.id}"
}
