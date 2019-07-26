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
  sensitive = true
  value     = module.log_analytics_workspace.workspace_id
}
