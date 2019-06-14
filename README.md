# terraform-module-azure-aks
Terraform module that can be used to deploy an Azure Kubernetes Service.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| admin\_username | Username that will be used to access the cluster. | string | `"aksadmin"` | no |
| agent\_count | Amount of VMs that will be deployed to create the cluster. | string | `"2"` | no |
| cluster\_name | Name of the AKS cluster to deploy. This will be used also as the DNS prefix. | string | `"clustername"` | no |
| kubernetes\_version | Version of kubernetes used in the cluster. | string | `"1.13.5"` | no |
| location | Location where the resource group and cluster will be deployed. | string | `"canadacentral"` | no |
| log\_analytics\_workspace\_name | Name of the log analytics workspace that will host the cluster telemetric data. | string | `"fxloganalytics"` | no |
| log\_analytics\_workspace\_retentionDays | Retention days for log analytics workspace. If SKU is free, leave empty, else 30 to 730 days. | string | `"30"` | no |
| log\_analytics\_workspace\_sku | SKU of the log analytics workspace that will host the cluster telemetric data. | string | `"free"` | no |
| rbac\_enabled | Define if RBAC feature is enabled or not. | string | `"false"` | no |
| resource\_group\_name | Name of the resource group that will be created and host with the cluster. | string | `"aks"` | no |
| service\_principal\_client\_id | Client ID of the service principal created for the cluster. | string | n/a | yes |
| service\_principal\_client\_secret | Secret of the service principal. | string | n/a | yes |
| ssh\_public\_key | Public key for aksadmin's SSH access.  Will default to the contents of ~/.ssh/id_rsa.pub. | string | `""` | no |
| tags | Tags that will be applied to the resource group and cluster. The default contains the tags that fits with FX's policies. | map | `{ "FXDepartment": "cloud", "FXOwner": "Name", "FXProject": "FXCL" }` | no |
| vm\_os\_disk\_gb\_size | Size of the OS disk for each agent. | string | `"30"` | no |
| vm\_size | Sizing of each of the agents that makes the cluster. | string | `"Standard_DS2_v2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| host |  |
| kube\_config |  |
| log\_analytics\_workspace\_id |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
