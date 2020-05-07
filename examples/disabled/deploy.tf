module "aks_cluster" {
  source = "../../"

  enabled = false

  resource_group_name                   = "tftest-aks"
  location                              = "canadacentral"
  name                                  = "tftest-aks"
  kubernetes_version                    = "1.13.5"
  dns_prefix                            = "kubernetes"
  log_analytics_workspace_name          = "tftest-aks"
  log_analytics_workspace_sku           = "free"
  log_analytics_workspace_retentionDays = 30
  rbac_enabled                          = true
  default_node_pool = [
    {
      name            = "tftestaks"
      type            = "VirtualMachineScaleSets"
      node_count      = 1
      vm_size         = "Standard_D2_v2"
      max_pods        = 2
      os_disk_size_gb = 30
    }
  ]
  admin_username   = "testadmin"
  ssh_key_key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDD3gEe3zm4Z5AZtAD1qhD6f5hyg6qMBQA8SuMAVtAP8q8k/kFu/oCU6DUMUBO83SQIXBnEniBs2EMl8xUMXShrmYqHZE6bZZeBVg2y8Kr2ReCCSMPH5TDbPTWrGJR7x0SIBXgsjctOazCyMBB98lMgcK++P0PQnqGSvRj7iZbiyN2KNaXE1ukZ4USGeTWxoh9NFVilIt5R0pI5CECSLajKgXJMUl3QWc5bHL8fSpvHqoRfItiPEmpm5pSQb519jkdT7ohnhSwIA8qBo6sAnfrRH0ydLT3swglyn44FDs4hCSSK1Hu4n1vYMBWgzGyfxWJlVV483MJYduxamMGIpyjgLCRcQ7sIwWnkSepKpj6okEN+0D9JM/64uk5p0oZ1bBQ3UU/D1XDxOHkyOobFiGUn2GSnKs3CdDhLbKobjK2RN6Qs/mqJ2Ux8eqQr4n76X/4xHuuqtJMc/OyfOKTRE7BZ7MhBP5r6btMks2GEATye34qiHwH7YNy1/no2ynW8RI8= test@tests"

  tags = {
    "inspec" = "true"
    "test"   = "true"
  }
}
