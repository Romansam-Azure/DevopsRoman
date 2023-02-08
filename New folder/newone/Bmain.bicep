param Keyvaultname string = 'virtualmsspt2'
param vmssName string = 'rianest'
param location string = 'southeastasia'

resource keyvault 'Microsoft.KeyVault/vaults@2022-07-01' existing = {
  name: Keyvaultname
}

module virtualmachinescaleset 'brrianvmssazkv.bicep' = {
  name: vmssName

  params: { 
    location: location
    adminPasswordkv: keyvault.getSecret('virtualm')
    adminUsername: keyvault.getSecret('viruser')
  }
}
