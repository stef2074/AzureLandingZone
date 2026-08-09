# JobAssistant Development

Deploys the infrastructure required to host the JobAssistant application within the Development subscription. This module establishes the application hosting foundation required to support the JobAssistant web application using Azure App Service.

## Resources

The following resources are managed by this module:

### Application Resources

- Resource Group
- App Service Plan
- App Service
- App Service Diagnostic Setting

Future application resources, such as Azure SQL Database, Storage Accounts, Key Vault, Application Insights, and networking integrations, are intentionally managed separately and are not created by this module.

### Monitoring Integration

The App Service Diagnostic Setting sends HTTP, console, and platform logs to the centralized Log Analytics Workspace in the Management subscription.

The Log Analytics Workspace is managed by the Monitoring Foundation and is discovered by this module using the Management subscription provider.

## Prerequisites

Before running Terraform:

- Ensure your Azure account has the required permissions for the Development and Management subscriptions.
- Authenticate to Azure:

```bash
az login
```

- Copy `backend.tf.example` to `backend.tf`.
- Copy `terraform.tfvars.example` to `terraform.tfvars`.
- Update both files with values appropriate for your Azure environment.

## Deployment

1. Run:

```bash
terraform init
terraform plan
terraform apply
```

## Terraform State

This module stores its Terraform state in the remote backend using:

```text
application-jobassistant-development.tfstate
```