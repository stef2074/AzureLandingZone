# Monitoring

## Purpose

Deploys the Azure Landing Zone Monitoring Foundation using Terraform.

The Monitoring deployment provisions the foundational monitoring infrastructure within the Management subscription and centralizes Activity Logs from the Management, Connectivity, and Development subscriptions into a shared Log Analytics Workspace. This deployment establishes the foundation for future monitoring, alerting, governance, and security capabilities.

## Resources

This deployment manages the following Azure resources:

- Monitoring Resource Group
- Log Analytics Workspace
- Management subscription Activity Log diagnostic setting
- Connectivity subscription Activity Log diagnostic setting
- Development subscription Activity Log diagnostic setting

## Prerequisites

Before deploying this module:

- Terraform backend is configured.
- Azure CLI is authenticated.
- Management, Connectivity, and Development subscriptions exist.
- Platform Connectivity deployment has been completed successfully.
- Terraform remote backend is accessible.

## Deployment

Run the following commands:

```bash
terraform fmt
terraform validate
terraform plan
terraform apply
```

## Expected Outcome

After deployment:

- The `rg-monitoring` resource group exists within the Management subscription.
- The `law-monitoring` Log Analytics Workspace exists within the Monitoring Resource Group.
- Activity Logs from the Management subscription are forwarded to the Log Analytics Workspace.
- Activity Logs from the Connectivity subscription are forwarded to the Log Analytics Workspace.
- Activity Logs from the Development subscription are forwarded to the Log Analytics Workspace.
- `terraform plan` reports no infrastructure changes after deployment.