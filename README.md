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
- Development Landing Zone

### Planned

- Shared Services
- Monitoring
- Governance

## Repository Structure

```text
AzureLandingZone/
├── bootstrap/            Terraform backend bootstrap
├── docs/                 Architecture and engineering documentation
├── landing-zones/        Landing Zone deployments
│   └── development/	  Development landing zone
├── management-groups/    Management Group hierarchy
├── modules/              Reusable Terraform modules
├── platform/             Platform infrastructure
│   ├── connectivity/	  Hub networking
│   └── management/	  Shared management resources
├── scripts/              Automation scripts
└── shared/               Shared configuration
```

## Technologies

- Terraform
- Microsoft Azure
- Azure CLI
- Git
- GitHub

## Documentation

Project documentation is located in the `docs` directory.

Each deployment module also contains its own README describing its purpose, prerequisites, and deployment process.

## License

This project is licensed under the MIT License.

See the [LICENSE](LICENSE) file for details.
