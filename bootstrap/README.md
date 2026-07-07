# Bootstrap

Creates the Terraform backend infrastructure used by all Azure Landing Zone deployments. This module establishes the remote backend required before any additional infrastructure is deployed.

## Resources

The following resources are created:

- Resource Group
- Storage Account
- Blob Container

This module creates only the Terraform backend infrastructure. It does **not** create Azure Landing Zone resources such as:

- Management Groups
- Networking
- Monitoring
- Landing Zones

## Prerequisites

Before running Terraform:

- Ensure Terraform is installed.
- Ensure the Azure CLI is installed.
- Authenticate to Azure:

``` bash
az login
```

- Copy `backend.tf.example` to `backend.tf`.
- Copy `terraform.tfvars.example` to `terraform.tfvars`.
- Update both files with values appropriate for your Azure environment.

## Deployment

1. Run:

``` bash
terraform init
terraform plan
terraform apply
```

2. After the backend infrastructure has been successfully deployed, migrate the Terraform state:

``` bash
terraform init -migrate-state
```

## Terraform State

This module initially uses local Terraform state to create the Azure Storage backend. After the migration completes, all subsequent Terraform operations use the remote backend stored in Azure Storage.
