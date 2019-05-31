resource_group_name = "aks"
location = "canadacentral"
cluster_name = "akscluster"
kubernetes_version = "1.13.5"
admin_username = "ubuntu"
ssh_public_key = ""
agent_count = 3
vm_size = "Standard_DS2_v2"
vm_os_disk_gb_size = 40
log_analytics_workspace_name = "fxloganalytics"
log_analytics_workspace_sku = "free"
log_analytics_workspace_retentionDays = 30
tags = {
    FXOwner      = "Name"
    FXDepartment = "cloud"
    FXProject    = "FXCL"
  }