# Azure Static Web Apps Deployment

## Package layout

- `app/`: PWA content deployed to Azure Static Web Apps.
- `.github/workflows/azure-static-web-apps.yml`: GitHub Actions deployment workflow.
- `infra/main.bicep`: Azure resource definition.
- `deploy-infrastructure.ps1`: PowerShell infrastructure deployment helper.
- `deploy-infrastructure.sh`: Bash infrastructure deployment helper.

## Prerequisites

- An Azure subscription.
- Azure CLI authenticated with `az login`.
- A GitHub repository for this package.
- Permission to add a GitHub Actions repository secret.

## 1. Create the Azure resource

PowerShell:

```powershell
./deploy-infrastructure.ps1 -SubscriptionId "YOUR-SUBSCRIPTION-ID"
```

Bash:

```bash
./deploy-infrastructure.sh "YOUR-SUBSCRIPTION-ID"
```

The default resource group is `rg-empire-restoration-estimator` and the default Static Web App name is `empire-restoration-estimator`. Change the name if Azure reports that it is unavailable.

## 2. Obtain the deployment token

In Azure Portal, open the new Static Web App and copy the deployment token. Do not place the token in source control.

## 3. Configure GitHub

Create this repository secret:

```text
AZURE_STATIC_WEB_APPS_API_TOKEN
```

Paste the Azure deployment token as the secret value.

## 4. Push to GitHub

Commit this complete folder to the `main` branch. The workflow deploys the prebuilt files from `/app` and skips the build step.

## 5. Verify

Open the default Azure Static Web Apps hostname. Confirm:

- The estimator interface loads.
- The manifest is detected.
- The service worker registers.
- Edge or Chrome offers installation.
- The estimator launches after the connection is turned off.

## 6. Optional custom domain

Add the desired domain in the Azure Static Web App's **Custom domains** section, then follow Azure's DNS validation prompts.

## Security note

The included `staticwebapp.config.json` adds security headers and same-origin routing. Authentication is not enabled in this initial deployment package. OneDrive synchronization requires a separate Microsoft identity and Microsoft Graph configuration; do not paste client secrets into the PWA.
