param resourceId_Microsoft_Compute_virtualMachines_parameters_VMName object
param vaultName string
param tenantId string

resource vaultName_add 'Microsoft.KeyVault/vaults/accessPolicies@2019-09-01' = {
  name: '${vaultName}/add'
  properties: {
    accessPolicies: [
      {
        tenantId: tenantId
        objectId: resourceId_Microsoft_Compute_virtualMachines_parameters_VMName.identity.principalId
        permissions: {
          keys: [
            'all'
          ]
          secrets: [
            'all'
          ]
          certificates: [
            'all'
          ]
          storage: [
            'all'
          ]
        }
      }
    ]
  }
}