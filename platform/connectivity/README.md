# Platform Connectivity

Deploys the core networking infrastructure for the Azure Landing Zone within the Connectivity subscription. This module establishes the networking foundation required to support future hybrid connectivity, platform services, and landing zones.

## Resources

The following resources are managed by this module:

### Networking Resources

- Resource Group
- Virtual Network
- Gateway Subnet
- Shared Services Subnet
- Network Security Group
- Route Table
- Network Security Group association
- Route Table association

Future hybrid connectivity resources, such as VPN Gateway, Local Network Gateway, and Site-to-Site VPN connections, are intentionally managed by separate modules and are not created by this module.

## Prerequisites

Before running Terraform:

- Ensure your Azure account has the required permissions for the Connectivity subscription.
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
platform-connectivity.tfstate
```
