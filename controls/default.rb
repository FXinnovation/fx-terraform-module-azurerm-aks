#
# inspec_profile::azurerm-aks
# controls::default
#
# author:cloudsquad@fxinnovation.com
# description: Default controls for azurerm-aks
#

###
# Attributes handling
###
enabled             = attribute('enabled')
location            = attribute('location')
resource_group_name = attribute('resource_group_name')
name                = attribute('name')
kubernetes_version  = attribute('kubernetes_version')
dns_prefix          = attribute('dns_prefix')

###
# Calling Dependencies Controls
###
include_controls 'azurerm-resource-group'
include_controls 'azurerm-log-analytics-workspace'

###
# Controls
###
control 'azure-kubernetes-service' do
  impact 1.0
  title  'Check the azure kubernetes service'
  tag    'azurerm'
  tag    'aks'

  describe azurerm_aks_cluster(resource_group: resource_group_name, name: name) do
    it                                  { should exist }
    its('properties.provisioningState') { should cmp 'Succeeded' }
    its('properties.kubernetesVersion') { should cmp kubernetes_version }
    its('properties.dnsPrefix')         { should cmp dns_prefix }
    its('location')                     { should cmp location }
    its('tags')                         { should include 'Terraform' }
    its('Terraform_tag')                { should cmp "true" }
  end if enabled

  describe azurerm_aks_cluster(resource_group: resource_group_name, name: name) do
    it                                  { should_not exist }
  end unless enabled
end
