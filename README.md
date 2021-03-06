# terraform-module-azure-aks
Terraform module that can be used to deploy an Azure Kubernetes Service.

**NOTE: This module uses both azuread and azurerm providers. They should be set accordingly.**

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| azurerm | >= 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 2.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| admin\_username | The admin username for the cluster. Changing this forces a new resource to be created. | `string` | `"testadmin"` | no |
| default\_node\_pool | List of maps representing an agent pool profile. | `list` | n/a | yes |
| dns\_prefix | DNS prefix for the inside the kubernetes cluster. | `string` | `"kubernetes"` | no |
| enabled | Whether to enable or not this module | `bool` | `true` | no |
| kubernetes\_version | Version of kubernetes used in the cluster. | `string` | `"1.16.7"` | no |
| location | Location where the resource group and cluster will be deployed. | `string` | `"canadacentral"` | no |
| log\_analytics\_workspace\_name | Name of the log analytics workspace that will host the cluster telemetric data. | `string` | `"fxloganalytics"` | no |
| log\_analytics\_workspace\_retentionDays | Retention days for log analytics workspace. If SKU is free, leave empty, else 30 to 730 days. | `string` | `"30"` | no |
| log\_analytics\_workspace\_sku | SKU of the log analytics workspace that will host the cluster telemetric data. | `string` | `"free"` | no |
| log\_analytics\_workspace\_tags | Additional tags to add to the log analytics workspace. | `map` | `{}` | no |
| name | Name of the AKS cluster to deploy. This will be used also as the DNS prefix. Will also be used for the service principal. | `string` | `"clustername"` | no |
| rbac\_enabled | Define if RBAC feature is enabled or not. | `bool` | `false` | no |
| resource\_group\_name | Name of the resource group that will be created and host with the cluster. | `string` | `"aks"` | no |
| resource\_group\_tags | Tags you want to apply to the resource group. | `map` | `{}` | no |
| ssh\_key\_key\_data | The public SSH key used to access the cluster. Changing this forces a new resource to be created. | `string` | `null` | no |
| tags | Tags that will be applied on all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| fqdn | n/a |
| id | n/a |
| kube\_admin\_config | n/a |
| kube\_config | n/a |
| log\_analytics\_workspace\_id | n/a |
| log\_analytics\_workspace\_primary\_shared\_key | n/a |
| log\_analytics\_workspace\_secondary\_shared\_key | n/a |
| log\_analytics\_workspace\_workspace\_id | n/a |
| resource\_group\_id | n/a |
| resource\_group\_name | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## agent-pool-profiles
Example:
```
[
  {
    name            = "tftest-aks"
    count           = 1
    vm_size         = "Standard_DS2_V2"
    os_type         = "Linux"
    os_disk_size_gb = 30
  }
]
```
