variable "enable" {
  type        = string
  default     = "true"
  description = "Wheter to enable or not this module"
}

variable "resource_group_name" {
  type        = string
  default     = "aks"
  description = "Name of the resource group that will be created and host with the cluster."
}

variable "resource_group_tags" {
  default     = {}
  description = "Tags you want to apply to the resource group."
}

variable "location" {
  type        = string
  default     = "canadacentral"
  description = "Location where the resource group and cluster will be deployed."
}

variable "cluster_name" {
  type        = string
  default     = "clustername"
  description = "Name of the AKS cluster to deploy. This will be used also as the DNS prefix."
}

variable "kubernetes_version" {
  type        = string
  default     = "1.13.5"
  description = "Version of kubernetes used in the cluster."
}

variable "service_principal_client_id" {
  type        = string
  description = "Client ID of the service principal created for the cluster."
}

variable "service_principal_client_secret" {
  type        = string
  description = "Secret of the service principal."
}

variable "agent_count" {
  default     = 2
  description = "Amount of VMs that will be deployed to create the cluster."
}

variable "vm_size" {
  type        = string
  default     = "Standard_DS2_v2"
  description = "Sizing of each of the agents that makes the cluster."
}

variable "vm_os_disk_gb_size" {
  default     = 30
  description = "Size of the OS disk for each agent. "
}

variable "log_analytics_workspace_name" {
  type        = string
  default     = "fxloganalytics"
  description = "Name of the log analytics workspace that will host the cluster telemetric data."
}

variable "log_analytics_workspace_sku" {
  type        = string
  default     = "free"
  description = "SKU of the log analytics workspace that will host the cluster telemetric data."
}

variable "log_analytics_workspace_retentionDays" {
  default     = "30"
  description = "Retention days for log analytics workspace. If SKU is free, leave empty, else 30 to 730 days."
}

variable "rbac_enabled" {
  type        = string
  default     = "false"
  description = "Define if RBAC feature is enabled or not."
}

variable "tags" {
  type = map(string)

  default = {
    FXOwner      = "Name"
    FXDepartment = "cloud"
    FXProject    = "FXCL"
  }

  description = "Tags that will be applied to the resource group and cluster. The default contains the tags that fits with FX's policies."
}
