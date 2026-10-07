param(
  [string]$SubscriptionId,
  [string]$ResourceGroupName = "rg-empire-restoration-estimator",
  [string]$Location = "westus2",
  [string]$StaticWebAppName = "empire-restoration-estimator"
)

$ErrorActionPreference = "Stop"

if (-not (Get-Command az -ErrorAction SilentlyContinue)) {
  throw "Azure CLI is required. Install it, then run az login."
}

az account set --subscription $SubscriptionId
az group create --name $ResourceGroupName --location $Location --output table
az deployment group create `
  --resource-group $ResourceGroupName `
  --template-file "./infra/main.bicep" `
  --parameters staticWebAppName=$StaticWebAppName location=$Location skuName=Free `
  --output table

Write-Host "Infrastructure created. In Azure Portal, open the Static Web App, copy its deployment token, and save it in GitHub as AZURE_STATIC_WEB_APPS_API_TOKEN."
