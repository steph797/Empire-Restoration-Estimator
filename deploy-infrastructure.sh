#!/usr/bin/env bash
set -euo pipefail

SUBSCRIPTION_ID="${1:?Usage: ./deploy-infrastructure.sh SUBSCRIPTION_ID [RESOURCE_GROUP] [STATIC_WEB_APP_NAME]}"
RESOURCE_GROUP="${2:-rg-empire-restoration-estimator}"
STATIC_WEB_APP_NAME="${3:-empire-restoration-estimator}"
LOCATION="${AZURE_LOCATION:-westus2}"

az account set --subscription "$SUBSCRIPTION_ID"
az group create --name "$RESOURCE_GROUP" --location "$LOCATION" --output table
az deployment group create \
  --resource-group "$RESOURCE_GROUP" \
  --template-file ./infra/main.bicep \
  --parameters staticWebAppName="$STATIC_WEB_APP_NAME" location="$LOCATION" skuName=Free \
  --output table

echo "Infrastructure created. Copy the Azure Static Web Apps deployment token into the GitHub repository secret AZURE_STATIC_WEB_APPS_API_TOKEN."
