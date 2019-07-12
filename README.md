# terraform-module-azure-aks
Terraform module that can be used to deploy an Azure Kubernetes Service.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cluster\_agent\_pool\_count | Amount of VMs that will be deployed to create the cluster. | string | `"2"` | no |
| cluster\_agent\_pool\_name | Name of the agent pool inside your cluster. | string | `"agent-pool"` | no |
| cluster\_agent\_pool\_os\_type | OS type for the agents in the cluster pool. | string | `"linux"` | no |
| cluster\_agent\_pool\_vm\_os\_disk\_gb\_size | Size of the OS disk for each agent. | string | `"30"` | no |
| cluster\_agent\_pool\_vm\_size | Sizing of each of the agents that makes the cluster. | string | `"Standard_DS2_v2"` | no |
| cluster\_dns\_prefix | DNS prefix for the inside the kubernetes cluster. | string | `"kubernetes"` | no |
| cluster\_kubernetes\_version | Version of kubernetes used in the cluster. | string | `"1.13.5"` | no |
| cluster\_name | Name of the AKS cluster to deploy. This will be used also as the DNS prefix. | string | `"clustername"` | no |
| cluster\_rbac\_enabled | Define if RBAC feature is enabled or not. | string | `"false"` | no |
| cluster\_service\_principal\_client\_id | Client ID of the service principal created for the cluster. | string | n/a | yes |
| cluster\_service\_principal\_client\_secret | Secret of the service principal. | string | n/a | yes |
| cluster\_tags | Tags that will be applied to the resource group and cluster. The default contains the tags that fits with FX's policies. | map(string) | `{ "FXDepartment": "cloud", "FXOwner": "Name", "FXProject": "FXCL" }` | no |
| enabled | Wheter to enable or not this module | string | `"true"` | no |
| location | Location where the resource group and cluster will be deployed. | string | `"canadacentral"` | no |
| log\_analytics\_workspace\_name | Name of the log analytics workspace that will host the cluster telemetric data. | string | `"fxloganalytics"` | no |
| log\_analytics\_workspace\_retentionDays | Retention days for log analytics workspace. If SKU is free, leave empty, else 30 to 730 days. | string | `"30"` | no |
| log\_analytics\_workspace\_sku | SKU of the log analytics workspace that will host the cluster telemetric data. | string | `"free"` | no |
| resource\_group\_name | Name of the resource group that will be created and host with the cluster. | string | `"aks"` | no |
| resource\_group\_tags | Tags you want to apply to the resource group. | map | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| host |  |
| kube\_config |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
