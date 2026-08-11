# JobAssistant GitHub Actions OIDC Authentication

Deploys the identity and authorization infrastructure required for JobAssistant GitHub Actions to authenticate to Azure using OpenID Connect (OIDC). This module establishes passwordless workload identity federation between the JobAssistant GitHub repository and Microsoft Entra ID.

## Resources

The following resources are managed by this module:

### Identity Resources

- Microsoft Entra Application
- Service Principal
- Federated Identity Credential

The Federated Identity Credential trusts GitHub Actions running in the `development` environment of the `stef2074/JobAssistant` repository. The OIDC subject includes the immutable GitHub repository owner ID and repository ID so that the federated trust remains bound to the intended owner and repository if either is renamed.

### Authorization

The Service Principal is assigned the Website Contributor role scoped to the JobAssistant Resource Group in the Development subscription.

The JobAssistant Resource Group is managed by the JobAssistant Development module and is discovered by this module using an Azure Resource Manager data source.

This module does not create or manage the JobAssistant application hosting resources.

## Prerequisites

Before running Terraform:

- Ensure your Azure account has the required permissions for Microsoft Entra ID and the Development subscription.
- Ensure the `development` environment exists in the JobAssistant GitHub repository.
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
application-jobassistant-github-oidc.tfstate
```
