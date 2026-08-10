# Azure Landing Zone

This repository contains the Terraform code used to deploy an Azure Landing Zone following Microsoft's Cloud Adoption Framework (CAF).

The project is being developed incrementally, with each feature implemented, documented, tested, and version controlled before moving to the next phase.

## Objectives

- Build an Azure Landing Zone using Terraform.
- Follow Infrastructure as Code (IaC) best practices.
- Implement Microsoft's Cloud Adoption Framework.
- Deploy all infrastructure through Terraform.
- Maintain a secure, modular, and reusable codebase.

## Current Status

**Note**

This repository is under active development. Features are implemented incrementally using feature branches, peer review, and documented engineering practices.

### Completed

- Bootstrap Terraform backend
- Azure Storage remote state
- Project architecture documentation
- Engineering principles
- Repository structure
- Azure Management Group hierarchy
- Azure subscription placement
- Platform Connectivity
- Monitoring Foundation
- Development Landing Zone
- JobAssistant App Service infrastructure and centralized logging

### Planned

- JobAssistant GitHub Actions OIDC authentication
- JobAssistant GitHub Actions CI/CD deployment workflow
- Shared Services
- Governance

## Repository Structure

```text
AzureLandingZone/
├── applications/          Application workload deployments
│   └── jobassistant/
│       ├── development/    JobAssistant Development infrastructure
│       └── github-oidc/    JobAssistant GitHub Actions OIDC authentication
├── bootstrap/             Terraform backend bootstrap
├── docs/                  Architecture and engineering documentation
├── landing-zones/         Landing Zone deployments
│   └── development/       Development Landing Zone
├── management-groups/     Management Group hierarchy
├── modules/               Reusable Terraform modules
├── platform/              Platform infrastructure
│   ├── connectivity/      Hub networking
│   ├── management/        Shared management resources
│   └── monitoring/        Centralized monitoring foundation
├── scripts/               Automation scripts
└── shared/                Shared configuration
```

## Technologies

- Terraform
- Microsoft Azure
- Azure CLI
- Microsoft Entra ID
- Git
- GitHub
- GitHub Actions

## Documentation

Project documentation is located in the `docs` directory.

Each deployment module also contains its own README describing its purpose, prerequisites, and deployment process.

## License

This project is licensed under the MIT License.

See the [LICENSE](LICENSE) file for details.
