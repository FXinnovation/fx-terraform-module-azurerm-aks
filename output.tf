output "host" {
  value = "${var.rbac_enabled == "true" ?  azurerm_kubernetes_cluster.this_withRBAC.kube_config.0.host : azurerm_kubernetes_cluster.this_noRBAC.kube_config.0.host }"
}

output "kube_config" {
  value = "${var.rbac_enabled == "true" ? azurerm_kubernetes_cluster.this_withRBAC.kube_config_raw : azurerm_kubernetes_cluster.this_noRBAC.kube_config_raw}"
}

output "log_analytics_workspace_id" {
  value = "${azurerm_log_analytics_workspace.this_ws.id}"
}
