variable "enabled" {
  type        = bool
  default     = true
  description = "Whether to enable or not this module"
}

variable "location" {
  type        = string
  default     = "canadacentral"
  description = "Location where the resource group and cluster will be deployed."
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

variable "name" {
  type        = string
  default     = "clustername"
  description = "Name of the AKS cluster to deploy. This will be used also as the DNS prefix. Will also be used for the service principal."
}

variable "kubernetes_version" {
  type        = string
  default     = "1.13.5"
  description = "Version of kubernetes used in the cluster."
}

variable "dns_prefix" {
  type        = string
  default     = "kubernetes"
  description = "DNS prefix for the inside the kubernetes cluster."
}

variable "default_node_pool" {
  type        = list
  description = "List of maps representing an agent pool profile."
}

variable "admin_username" {
  description = "The admin username for the cluster. Changing this forces a new resource to be created."
  type        = string
  default     = "testadmin"
}

variable "ssh_key_key_data" {
  description = "The public SSH key used to access the cluster. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "rbac_enabled" {
  type        = bool
  default     = false
  description = "Define if RBAC feature is enabled or not."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags that will be applied on all resources."
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

variable "log_analytics_workspace_tags" {
  default     = {}
  description = "Additional tags to add to the log analytics workspace."
}
