# Monitoring

## Purpose

Deploys the Azure Landing Zone monitoring foundation using Terraform.

The monitoring deployment provisions the foundational monitoring infrastructure within the Management subscription and centralizes activity logs from the Management, Connectivity, and Development subscriptions into a shared log analytics workspace. This deployment establishes the foundation for future monitoring, alerting, governance, and security capabilities.

## Resources

This deployment manages the following Azure resources:

- Monitoring resource group
- Log analytics workspace
- Management subscription activity log diagnostic setting
- Connectivity subscription activity log diagnostic setting
- Development subscription activity log diagnostic setting

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
- The `law-monitoring` log analytics workspace exists within the monitoring resource group.
- Activity logs from the Management subscription are forwarded to the log analytics workspace.
- Activity logs from the Connectivity subscription are forwarded to the log analytics workspace.
- Activity logs from the Development subscription are forwarded to the log analytics workspace.
- `terraform plan` reports no infrastructure changes after deployment.