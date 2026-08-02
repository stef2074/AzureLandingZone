# Development Landing Zone

Deploys the foundational infrastructure for the Azure Landing Zone within the Development subscription. This module establishes the networking foundation required to support future development workloads while integrating the Development Virtual Network with the Platform Connectivity hub.

## Resources

The following resources are managed by this module:

### Networking Resources

- Resource Group
- Virtual Network
- Development Subnet
- Network Security Group
- Route Table
- Network Security Group association
- Route Table association
- VNet peering to the Platform Connectivity hub

Future development workloads, such as Virtual Machines, App Services, Azure Kubernetes Service (AKS), Azure SQL Database, and Storage Accounts, are intentionally managed by separate modules and are not created by this module.

## Prerequisites

Before running Terraform:

- Ensure your Azure account has the required permissions for the Development subscription.
- Ensure the Platform Connectivity deployment has been successfully deployed.
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
landing-zone-development.tfstate
```
