# Azure Landing Zone Architecture

## Overview

This project provisions an Azure Landing Zone using Terraform and follows Infrastructure as Code (IaC) principles. The goal is to build a modular, scalable, and maintainable Azure platform that aligns with Microsoft's Cloud Adoption Framework while remaining practical for a personal lab environment.

The repository is organized into independent deployment units. Each deployment owns a specific portion of the infrastructure and maintains its own Terraform state.

---

# Management Group Hierarchy

```text
Tenant Root
├── Platform
│   ├── Management
│   └── Connectivity
└── LandingZones
    └── Development
```

---

# Subscriptions

| Subscription | Purpose |
|---------------|---------|
| Management | Terraform state, monitoring, logging, shared platform services |
| Connectivity | Hub networking, Private DNS, routing, future Firewall/VPN/Bastion |
| Development | Development workloads and spoke networking |

---

# Repository Structure

```text
AzureLandingZone/
│
├── bootstrap/
│
├── management-groups/
│
├── platform/
│   ├── management/
│   └── connectivity/
│
├── landing-zones/
│   └── development/
│
├── modules/
├── shared/
├── docs/
└── scripts/
```

---

# Repository Design

The repository follows a simple architectural rule:

> **Deployments own infrastructure. Modules define reusable infrastructure.**

### Deployments

Deployments represent complete pieces of infrastructure that can be independently deployed.

Examples:

- bootstrap
- management-groups
- platform/management
- platform/connectivity
- landing-zones/development

### Modules

Modules are reusable building blocks.

Examples:

- Resource Groups
- Virtual Networks
- Network Security Groups
- Key Vault
- Log Analytics
- Storage Accounts
- Role Assignments

Modules should never assume where they are being deployed. They simply create infrastructure from supplied variables.

---

# Terraform State Strategy

Terraform state will be stored in the **Management** subscription.

Each deployment maintains an independent state file.

```text
bootstrap.tfstate
management-groups.tfstate
platform-management.tfstate
platform-connectivity.tfstate
landingzone-development.tfstate
```

Benefits of separating state:

- Smaller blast radius
- Independent deployments
- Faster Terraform operations
- Easier collaboration
- Easier troubleshooting

---

# Bootstrap Strategy

The bootstrap deployment is responsible for creating the Terraform backend.

Initially it will use **local state** to create:

- Resource Group
- Storage Account
- Blob Container

Once complete, all remaining deployments will use the remote backend.

---

# Engineering Principles

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

## Terraform Naming Convention

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

# Current Design Decisions

## Decision 001

Terraform remote state will be hosted in the **Management** subscription.

---

## Decision 002

Management Groups are deployed independently and are **not** part of the bootstrap deployment.

---

## Decision 003

Each major deployment owns its own Terraform state.

---

## Decision 004

The initial landing zone consists of:

```text
Tenant Root
├── Platform
│   ├── Management
│   └── Connectivity
└── LandingZones
    └── Development
```

---

## Decision 005

An Identity subscription is intentionally omitted from the initial implementation. Microsoft Entra ID is tenant-wide and a dedicated Identity subscription is unnecessary for the current scope.

---

## Decision 006

Modules define reusable infrastructure.

Deployments consume modules and own the resulting infrastructure.

---

# Future Enhancements

Possible future additions include:

- Testing Landing Zone
- Production Landing Zone
- Azure Firewall
- Azure Bastion
- VPN Gateway
- Azure Policy
- Azure Budgeting
- Defender for Cloud
- GitHub Actions CI/CD
- Azure DevOps Pipeline

---

## Terraform Authentication

Initial local Terraform execution uses Azure CLI authentication.

Future automated deployments should use Managed Identity or Workload Identity Federation instead of long-lived credentials.

Authentication strategy:

```text
Local Development      -> Azure CLI authentication
Automation / Pipeline  -> Managed Identity / Workload Identity
```

---

## Additional Engineering Principles

- Prefer explicit, readable Terraform over clever or highly condensed configurations.
- Optimize for maintainability over minimal code.
- One deployment owns one responsibility.
- Commit one logical change at a time with clear commit messages.

---

## Decision 007

Terraform resource names should describe the **role** of the resource (for example, `backend`, `hub`, `monitoring`) rather than generic or implementation-specific names.

---

## Decision 008

The bootstrap deployment owns only the Terraform backend infrastructure (Resource Group, Storage Account, and Blob Container). All other Azure resources are deployed by their respective deployments.

## Cost Philosophy

The Azure Landing Zone is designed to minimize development costs while following production engineering practices.

Where appropriate:

- Prefer low-cost Azure SKUs during development.
- Deploy only the resources required for the current module.
- Make high-cost services optional.
- Destroy unused resources when not actively testing.
