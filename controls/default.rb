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
location = attribute('location')

###
# Calling Dependencies Controls
###
include_controls 'azurerm-resource-group'
include_controls 'azurerm-log-analytics-workspace'

###
# Controls
###
control 'aks' do
  impact 1.0
  title  'Check the azure kubernetes service'
  tag    'azurerm'
  tag    'aks'
end
