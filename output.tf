output "service_principal_id" {
  value = "${module.service_principal.client_id}"
}

output "host" {
  value = "${azurerm_kubernetes_cluster.this.kube_config.0.host}"
}

output "kube_config" {
  value = "${azurerm_kubernetes_cluster.this.kube_config_raw}"
}

output "log_analytics_workspace_id" {
  value = "${azurerm_log_analytics_workspace.this_ws.id}"
}
