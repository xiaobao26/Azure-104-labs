param appServiceName string
param location string

@allowed([
  'nonprod'
  'prod'
])
param environmentType string

var appServicePlanName = 'toy-product-launch-plan-starter-072699'
var appServicePlanSkuName = (environmentType == 'prod') ? 'F1' : 'F1'

resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
  }
}

resource appService 'Microsoft.Web/sites@2024-04-01' = {
  name: appServiceName
  location: location
  properties: {
    serverFarmId:appServicePlan.id
    httpsOnly: true
  }
}

output appServiceAppHostName string = appService.properties.defaultHostName
