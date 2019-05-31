variable "resource_group_name" {
  type        = "string"
  description = "Name of the resource group that will be created and host with the cluster."
}

variable "location" {
  type        = "string"
  description = "Location where the resource group and cluster will be deployed."
}

variable "cluster_name" {
  type        = "string"
  description = "Name of the AKS cluster to deploy. This will be used also as the DNS prefix."
}

variable "kubernetes_version" {
  type        = "string"
  description = "Version of kubernetes used in the cluster."
}

variable "admin_username" {
  type        = "string"
  description = "Username that will be used to access the cluster."
}

variable "ssh_public_key" {
  type        = "string"
  default     = ""
  description = "Public key for aksadmin's SSH access.  Will default to the contents of ~/.ssh/id_rsa.pub."
}

variable "agent_count" {
  description = "Amount of VMs that will be deployed to create the cluster."
}

variable "vm_size" {
  type        = "string"
  description = "Sizing of each of the agents that makes the cluster."
}

variable "vm_os_disk_gb_size" {
  description = "Size of the OS disk for each agent. "
}

variable "log_analytics_workspace_name" {
  type        = "string"
  description = "Name of the log analytics workspace that will host the cluster telemetric data."
}

variable "log_analytics_workspace_sku" {
  type        = "string"
  default     = "free"
  description = "SKU of the log analytics workspace that will host the cluster telemetric data."
}

variable "log_analytics_workspace_retentionDays" {
  description = "Amount of days the data in log analytics will be retained. Can go from 30 to 730. If sku is free, leave empty."
}

variable "tags" {
  type        = "map"
  description = "Tags that will be applied to the resource group and cluster. The default contains the tags that fits with FX's policies."
}
