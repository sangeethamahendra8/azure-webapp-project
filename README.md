# Azure Scalable Web App Project

A Node.js web application deployed on Azure App Service, built to demonstrate core Azure Cloud Engineer skills: compute provisioning, networking, CI/CD, autoscaling, monitoring, and Infrastructure as Code.

## Live Demo
🔗 [sangeetha-webapp0701.azurewebsites.net](https://sangeetha-webapp0701-drhng7dtajfrfyhf.canadacentral-01.azurewebsites.net)

## Architecture

- **Compute:** Azure App Service (Linux, Node.js 22 LTS) running on a Standard S1 App Service Plan
- **Networking:** Virtual Network with a delegated subnet, connected to the Web App via regional VNet Integration for secure outbound traffic routing
- **CI/CD:** GitHub Actions pipeline — builds and deploys automatically on every push to `main`, authenticated via a publish profile stored as a GitHub secret
- **Autoscaling:** Custom autoscale rule — scales out from 1 to 3 instances when average CPU exceeds 70% for 10 minutes
- **Monitoring:** Application Insights for telemetry, plus an Azure Monitor metric alert (CPU > 70%) that notifies via an action group email
- **Infrastructure as Code:** Full environment defined in Bicep (see `/infra`) for repeatable, version-controlled deployments

## Project Structure
```
├── index.js              # App entry point
├── package.json           # Node dependencies and start script
├── .github/workflows/     # GitHub Actions CI/CD pipeline
└── infra/
    └── main.bicep          # Infrastructure as Code — full Azure environment
```

## How It Was Built

1. Provisioned a Resource Group, Virtual Network, and subnet
2. Created a Linux App Service Plan and Web App (Node.js runtime)
3. Connected GitHub Actions for automated build-and-deploy on push
4. Integrated the Web App with the VNet for private outbound routing
5. Configured CPU-based autoscaling (1–3 instances, 70% threshold)
6. Set up Azure Monitor alerting with email notifications
7. Exported the final environment to Bicep for Infrastructure as Code

## Redeploy from Scratch
```bash
az group create --name sangeetha-azureproj-rg --location canadacentral
az deployment group create \
  --resource-group sangeetha-azureproj-rg \
  --template-file infra/main.bicep
```

## Skills Demonstrated
Azure App Service · Virtual Networks · VNet Integration · Autoscaling · Azure Monitor · Application Insights · GitHub Actions CI/CD · Bicep (IaC)

---
Built by Sangeetha Mahendra
