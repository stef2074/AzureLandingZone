# Bootstrap

## Purpose

Creates the Terraform backend used by all Azure Landing Zone deployments.

## Resources

- Resource Group
- Storage Account
- Blob Container

## Terraform State

Uses local state.

## Creates

- Remote backend infrastructure

## Does Not Create

- Management Groups
- Networking
- Monitoring
- Landing Zones

## Authentication

Local development uses Azure CLI authentication.

```bash
az login
```

Future automation will use Azure Workload Identity (OIDC) or Managed Identity rather than stored credentials.

## Backend Migration

After deploying the bootstrap infrastructure, configure the remote backend:

```bash
terraform init -migrate-state
```

Terraform will migrate the local state file into the Azure Storage Account.
