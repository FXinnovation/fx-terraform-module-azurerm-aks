#
# inspec_profile::azurerm-aks
# controls::default
#
# author:cloudsquad@fxinnovation.com
# description: Default controls for azurerm-aks
#

###
# Inputs handling
###
enabled                      = input('enabled')
location                     = input('location')
resource_group_name          = input('resource_group_name')
name                         = input('name')
kubernetes_version           = input('kubernetes_version')
dns_prefix                   = input('dns_prefix')
# https://github.com/inspec/inspec/issues/4338
# log_analytics_workspace_name = input('log_analytics_workspace_name')


###
# Resource Group Profile
###
# Pending result of https://github.com/inspec/inspec/issues/4338
# input(
#   'name_prefix',
#   value: resource_group_name,
#   profile: 'azurerm-resource-group',
#   priority: 100
# )
# input(
#   'location',
#   value: location,
#   profile: 'azurerm-resource-group',
#   priority: 100
# )
# input(
#   'enabled',
#   value: enabled,
#   profile: 'azurerm-resource-group',
#   priority: 100
# )
#
include_controls 'azurerm-resource-group'

###
# Log Analytics Workspace Profile
###
# Pending result of https://github.com/inspec/inspec/issues/4338
# input(
#   'name',
#   value: log_analytics_workspace_name,
#   profile: 'azurerm-log-analytics-workspace',
#   priority: 100
# )
# input(
#   'resource_group_name',
#   value: resource_group_name,
#   profile: 'azurerm-log-analytics-workspace',
#   priority: 100
# )
# input(
#   'location',
#   value: location,
#   profile: 'azurerm-log-analytics-workspace',
#   priority: 100
# )
# input(
#   'enabled',
#   value: enabled,
#   profile: 'azurerm-log-analytics-workspace',
#   priority: 100
# )

include_controls 'azurerm-log-analytics-workspace'

###
# Service Principal Profile
###
include_controls 'azuread-service-principal'

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
    its('tags.Terraform')               { should cmp "true" }
  end if enabled

  describe azurerm_aks_cluster(resource_group: resource_group_name, name: name) do
    it { should_not exist }
  end unless enabled
end
