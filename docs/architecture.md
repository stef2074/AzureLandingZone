# Azure Landing Zone Architecture

## Overview

This project provisions an Azure Landing Zone using Terraform and follows Infrastructure as Code (IaC) principles. The goal is to build a modular, scalable, and maintainable Azure platform that aligns with Microsoft's Cloud Adoption Framework while remaining practical for a personal lab environment.

The repository is organized into independent deployment units. Each deployment owns a specific portion of the infrastructure and maintains its own Terraform state.

---

## Management Group Hierarchy

```text
Tenant Root
├── Platform
│   ├── Management
│   └── Connectivity
└── Landing Zones
    └── Development
```

---

## Subscriptions

| Subscription | Purpose |
|---------------|---------|
| Management | Terraform state, monitoring, logging, shared platform services |
| Connectivity | Hub networking, Private DNS, routing, future Azure Firewall, VPN Gateway, and Azure Bastion |
| Development | Development workloads and spoke networking |

---

## Platform Connectivity

The Connectivity subscription hosts the Hub Virtual Network that provides the networking foundation for the Azure Landing Zone.

```text
Connectivity Subscription
└── Hub Virtual Network (10.100.0.0/16)
    ├── GatewaySubnet (10.100.0.0/24)
    └── SharedServicesSubnet (10.100.1.0/24)
```

The Hub Virtual Network uses the `10.100.0.0/16` address space.

The project intentionally standardizes on `/24` subnets for readability, operational simplicity, and future expansion. Although Azure commonly recommends a smaller subnet for `GatewaySubnet`, the available `/16` address space provides ample capacity, making a consistent addressing scheme more valuable than conserving IP addresses.

---

## Platform Monitoring

The Management subscription hosts the monitoring foundation for the Azure Landing Zone.

```text
Management Subscription
└── Monitoring
    ├── Resource Group
    ├── Log Analytics Workspace
    ├── Management Activity Logs
    ├── Connectivity Activity Logs
    └── Development Activity Logs
```

The monitoring deployment centralizes Activity Logs from the Management, Connectivity, and Development subscriptions into a shared Log Analytics Workspace. This foundation supports future monitoring, alerting, governance, and security capabilities.

---

## Repository Structure

```text
AzureLandingZone/
│
├── bootstrap/
│
├── management-groups/
│
├── platform/
│   ├── management/
│   ├── connectivity/
│   └── monitoring/
│
├── landing-zones/
│   └── development/
│
├── applications/
│   └── jobassistant/
│       ├── development/
│       └── github-oidc/
│
├── modules/
├── shared/
├── docs/
└── scripts/
```

---

## Repository Design

The repository follows a simple architectural rule:

> **Deployments own infrastructure. Modules define reusable infrastructure.**

### Deployments

Deployments represent complete pieces of infrastructure that can be independently deployed.

Examples:

- bootstrap
- management-groups
- platform/management
- platform/connectivity
- platform/monitoring
- landing-zones/development
- applications/jobassistant/development
- applications/jobassistant/github-oidc

### Applications

Application deployments represent independently managed application workloads and supporting infrastructure.

Each application deployment is managed as its own Terraform root module and maintains its own Terraform state.

Example:

```text
applications/
└── jobassistant/
    ├── development/
    └── github-oidc/
```

Application deployments own application-specific infrastructure such as Resource Groups, App Service Plans, App Services, databases, workload identities, deployment authentication, and other workload resources.

Landing Zone deployments provide the foundational infrastructure required by applications but do not own application resources.

### Modules

Modules are reusable building blocks.

Examples:

- Resource Groups
- Virtual Networks
- Network Security Groups
- Azure Key Vault
- Log Analytics Workspace
- Storage Accounts
- Role Assignments

Modules should never assume where they are being deployed. They simply create infrastructure from supplied variables.

---

## Terraform State Strategy

Terraform state will be stored in the **Management** subscription.

Each deployment maintains an independent state file.

```text
bootstrap.tfstate
management-groups.tfstate
platform-management.tfstate
platform-connectivity.tfstate
platform-monitoring.tfstate
landing-zone-development.tfstate
application-jobassistant-development.tfstate
application-jobassistant-github-oidc.tfstate
```

Benefits of separating state:

- Smaller blast radius
- Independent deployments
- Faster Terraform operations
- Easier collaboration
- Easier troubleshooting

---

## Bootstrap Strategy

The bootstrap deployment is responsible for creating the Terraform backend.

Initially it will use **local state** to create:

- Resource Group
- Storage Account
- Blob Container

Once complete, all remaining deployments will use the remote backend.

---

## Engineering Principles

This project follows the following principles:

- Infrastructure as Code first
- Modular design
- Small, independent Terraform states
- Platform services separated from workloads
- Minimal manual Azure configuration
- Reusable modules
- Incremental development
- Documentation before implementation
- Be explicit when it improves safety

### Terraform Naming Convention

Terraform resource names describe the **role** of the resource rather than the Azure resource type or implementation detail.

Good examples:

```hcl
resource "azurerm_resource_group" "backend" {}

resource "azurerm_virtual_network" "hub" {}

resource "azurerm_virtual_network" "development" {}

resource "azurerm_log_analytics_workspace" "monitoring" {}
```

Avoid generic or implementation-based names such as:

```hcl
resource "azurerm_resource_group" "rg1" {}

resource "azurerm_storage_account" "tfstate" {}

resource "azurerm_virtual_network" "vnet1" {}
```

The goal is to make Terraform code read naturally and clearly communicate the purpose of each resource.

---

## Current Design Decisions

### Decision 001

Terraform remote state will be hosted in the **Management** subscription.

---

### Decision 002

Management Groups are deployed independently and are **not** part of the bootstrap deployment.

---

### Decision 003

Each major deployment owns its own Terraform state.

---

### Decision 004

The initial landing zone consists of:

```text
Tenant Root
├── Platform
│   ├── Management
│   └── Connectivity
└── Landing Zones
    └── Development
```

---

### Decision 005

An Identity subscription is intentionally omitted from the initial implementation. Microsoft Entra ID is tenant-wide and a dedicated Identity subscription is unnecessary for the current scope.

---

### Decision 006

Modules define reusable infrastructure.

Deployments consume modules and own the resulting infrastructure.

---

### Decision 007

Terraform resource names should describe the **role** of the resource (for example, `backend`, `hub`, `monitoring`) rather than generic or implementation-specific names.

---

### Decision 008

The bootstrap deployment owns only the Terraform backend infrastructure (Resource Group, Storage Account, and Blob Container). All other Azure resources are deployed by their respective deployments.

---

### Decision 009

Landing Zone deployments discover Platform resources using Azure data sources and environment-specific variables rather than Terraform remote state.

Rationale:

- Preserves the independence of Terraform state files.
- Reduces coupling between deployments.
- Follows the project's configuration management principles by supplying environment-specific values through variables.
- Treats Platform resources as existing Azure infrastructure rather than implementation details of another Terraform deployment.

---

### Decision 010

Application workloads are managed independently from Landing Zone infrastructure.

Application deployments are stored under the `applications/` directory and use separate Terraform root modules and state files for each application deployment.

This separation preserves independent lifecycles between foundational Landing Zone infrastructure and application workloads.

---

### Decision 011

GitHub Actions authentication for JobAssistant uses Microsoft Entra Workload Identity Federation with OpenID Connect (OIDC) rather than long-lived client secrets or App Service publish profiles.

A dedicated Microsoft Entra application and service principal establish the deployment identity. A federated identity credential restricts trust to the intended JobAssistant GitHub repository and deployment environment. Azure RBAC grants only the permissions required for deployment.

The OIDC authentication infrastructure is managed as an independent Terraform deployment under `applications/jobassistant/github-oidc/` and maintains its own Terraform state.

Rationale:

- Eliminates long-lived Azure credentials from GitHub.
- Uses short-lived tokens issued for individual GitHub Actions workflow jobs.
- Limits the trust relationship to the intended repository and deployment environment.
- Keeps deployment authentication infrastructure independent from the JobAssistant application hosting infrastructure.
- Establishes the authentication foundation for future JobAssistant CI/CD workflows.

---

## Future Enhancements

Possible future additions include:

- Testing Landing Zone
- Production Landing Zone
- Azure Firewall
- Azure Bastion
- VPN Gateway
- Azure Policy
- Azure Cost Management budgets
- Defender for Cloud
- JobAssistant GitHub Actions CI/CD deployment workflow
- Azure DevOps pipeline

---

## Terraform Authentication

Initial local Terraform execution uses Azure CLI authentication.

Automated deployments should use Managed Identity or Workload Identity Federation instead of long-lived credentials.

JobAssistant GitHub Actions authentication uses Microsoft Entra Workload Identity Federation with OpenID Connect (OIDC). GitHub Actions requests a short-lived OIDC token, Microsoft Entra ID validates the configured federated trust, and Azure authorizes the resulting workload identity through Azure RBAC.

Authentication strategy:

```text
Local Development             -> Azure CLI authentication
Azure-hosted automation       -> Managed Identity
GitHub Actions                -> Workload Identity Federation / OIDC
```

### JobAssistant GitHub Actions OIDC Authentication

```text
GitHub Actions
    │
    │ OIDC token
    ▼
Microsoft Entra ID
    │
    │ Federated identity credential
    ▼
JobAssistant deployment identity
    │
    │ Azure RBAC
    ▼
JobAssistant Azure resources
```

The federated identity credential is restricted to the intended JobAssistant GitHub repository and deployment environment. No Azure client secret or App Service publish profile is required for authentication.

The authentication infrastructure is managed independently under `applications/jobassistant/github-oidc/`. The actual JobAssistant build and deployment workflow is implemented separately from this authentication foundation.

---

## Additional Engineering Principles

- Prefer explicit, readable Terraform over clever or highly condensed configurations.
- Optimize for maintainability over minimal code.
- One deployment owns one responsibility.
- Commit one logical change at a time with clear commit messages.

---

## Cost Philosophy

The Azure Landing Zone is designed to minimize development costs while following production engineering practices.

Where appropriate:

- Prefer low-cost Azure SKUs during development.
- Deploy only the resources required for the current module.
- Make high-cost services optional.
- Destroy unused resources when not actively testing.
