# Bootstrap

## Purpose

Creates the Terraform backend used by all Azure Landing Zone deployments.

## Resources

Creates the following Azure resources:

- Resource Group
- Storage Account
- Blob Container

## Terraform State

The bootstrap deployment initially uses local Terraform state to create the Azure Storage backend.

After the backend infrastructure has been successfully deployed, migrate the Terraform state to the Azure Storage backend:

```bash
terraform init -migrate-state
```

After the migration completes, all subsequent Terraform operations use the remote backend stored in Azure Storage.

## Creates

- Remote backend infrastructure

## Does Not Create

The bootstrap deployment does **not** create any Azure Landing Zone resources, including:

- Management Groups
- Networking
- Monitoring
- Landing Zones

## Prerequisites

Before running Terraform:

- Install Terraform.
- Install the Azure CLI.
- Authenticate to Azure:

```bash
az login
```

- Copy `terraform.tfvars.example` to `terraform.tfvars`.
- Copy `backend.tf.example` to `backend.tf`.
- Update both files with values appropriate for your Azure environment.

## Authentication

Local development uses Azure CLI authentication.

Future automation should use Azure Workload Identity (OIDC) or Managed Identity instead of stored credentials.

## License

This project is licensed under the MIT License.

See the [LICENSE](../LICENSE) file for the complete license text.
