variable "resource_group_name" {
    type = "string"
    default =   "aks"
    description = "Name of the resource group that will be created and host with the cluster."
}

variable "cluster_name" {
    type = "string"
    default = "clustername"
    description = "Name of the AKS cluster to deploy. This will be used also as the DNS prefix."
}

variable "location" {
    type = "string"
    default =   "westeurope"
    description = "Location where the resource group and cluster will be deployed."
}

variable "admin_username" {
    type = "string"
    default = "aksadmin"
    description = "Username that will be used to access the cluster."
}

variable "ssh_public_key" {
   type         = "string"
   default      = ""
   description  = "Public key for aksadmin's SSH access.  Will default to the contents of ~/.ssh/id_rsa.pub."
}

variable "agent_count" {
    default =   2
    description = "Amount of VMs that will be deployed to create the cluster."
}

variable "vm_size" {
    type = "string"
    default =   "Standard_DS2_v2"
    description = "Sizing of each of the agents that makes the cluster."
}

variable "vm_os_disk_gb_size" {
    default = 30
    description = "Size of the OS disk for each agent. "
}

variable "tags" {
    default     = {
        FXOwner  = "Name"
        FXDepartment = "cloud"
        FXProject = "FXCL"
    }
    description = "Tags that will be applied to the resource group and cluster. The default contains the tags that fits with FX's policies."
}