# Management Groups

Deploys the Azure Management Group hierarchy for the Azure Landing Zone, establishing the governance foundation for future subscriptions, policies, and platform resources.

## Resources

The following resources are managed by this module:

### Management Groups

- Platform
  - Management
  - Connectivity
- Landing Zones
  - Development

### Subscription Assignments

- Management
- Connectivity
- Development

The Tenant Root Management Group is treated as an existing Azure resource and is not created by this module.

## Prerequisites

Before running Terraform:

- Ensure your Azure account has Management Group permissions.
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

## Terraform State

This module stores its Terraform state in the remote backend using:

``` text
management-groups.tfstate
```
