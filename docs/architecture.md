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

# Design Principles

This project follows the following principles:

- Infrastructure as Code first
- Modular design
- Small, independent Terraform states
- Platform services separated from workloads
- Minimal manual Azure configuration
- Reusable modules
- Incremental development
- Documentation before implementation

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

## Terraform Backend

Terraform remote state will use an Azure Storage Account located in the Management subscription.

The backend will use:

- Azure Resource Group
- Azure Storage Account
- Blob Container
- Separate state files per deployment

## Terraform Authentication

Initial local Terraform execution will use Azure CLI authentication.

Future automated deployments should use managed identity or workload identity federation instead of storing long-lived secrets.

Authentication strategy:

```text
Local Development      -> Azure CLI authentication
Automation / Pipeline  -> Managed Identity or Workload Identity
