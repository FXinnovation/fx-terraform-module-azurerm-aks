locals {
  default_ssh_public_key = "${file("~/.ssh/id_rsa.pub")}"
  ssh_public_key         = "${var.ssh_public_key != "" ? var.ssh_public_key : local.default_ssh_public_key }"
}

module "service_principal" {
  source  = "../terraform-module-azure-service_principal"
  sp_name = "${var.cluster_name}"
}

resource "azurerm_resource_group" "aks" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
  tags     = "${var.tags}"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.cluster_name}"
  location            = "${azurerm_resource_group.aks.location}"
  resource_group_name = "${azurerm_resource_group.aks.name}"
  dns_prefix          = "${var.cluster_name}"

  linux_profile {
    admin_username = "${var.admin_username}"

    ssh_key {
      key_data = "${local.ssh_public_key}"
    }
  }

  agent_pool_profile {
    name            = "default"
    count           = "${var.agent_count}"
    vm_size         = "${var.vm_size}"
    os_type         = "Linux"
    os_disk_size_gb = "${var.vm_os_disk_gb_size}"
  }

  service_principal {
    client_id     = "${module.service_principal.client_id}"
    client_secret = "${module.service_principal.client_secret}"
  }

  tags = "${var.tags}"
}
