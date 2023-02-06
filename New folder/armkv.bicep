param vaultName string = ''
param VMName string = ''
param tenantId string = subscription().tenantId
param location string = ''

resource VM 'Microsoft.Compute/virtualMachines@2020-06-01' = {
  name: VMName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
}

module nestedTemplate1 './nested_nestedTemplate1.bicep' = {
  name: 'nestedTemplate1'
  scope: resourceGroup('<key vault resource group>')
  params: {
    resourceId_Microsoft_Compute_virtualMachines_parameters_VMName: reference(VM.id, '2020-06-01', 'full')
    vaultName: vaultName
    tenantId: tenantId
  }
}

resource VMName_KeyVaultForWindows 'Microsoft.Compute/virtualMachines/extensions@2019-07-01' = {
  parent: VM
  name: 'KeyVaultForWindows'
  location: location
  properties: {
    publisher: 'Microsoft.Azure.KeyVault'
    type: 'KeyVaultForWindows'
    typeHandlerVersion: '1.0'
    autoUpgradeMinorVersion: true
    settings: {
      secretsManagementSettings: {
        pollingIntervalInS: '3600'
        certificateStoreName: 'MY'
        linkOnRenewal: false
        certificateStoreLocation: 'LocalMachine'
        observedCertificates: [
          ''
        ]
      }
    }
  }
  dependsOn: [
    nestedTemplate1
  ]
}