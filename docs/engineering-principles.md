# Engineering Principles

This document defines the engineering standards used throughout the Azure Landing Zone project. These principles promote consistency, readability, maintainability, and long-term sustainability.

Engineering principles describe **how** infrastructure is built. Architectural decisions are documented separately in `architecture.md`.

---

## Code Documentation

Comments should explain **why**, not **what**.

Prefer comments that document:

- Architectural decisions
- Design rationale
- Assumptions
- Constraints
- Non-obvious behavior

Avoid comments that merely restate what the Terraform configuration already expresses.

Good comments provide context that cannot be inferred directly from the code.

### Good Examples

```hcl
# Explicitly specify the Management subscription to prevent
# accidental deployment to the active Azure CLI subscription.
provider "azurerm" {
  features {}

  subscription_id = var.management_subscription_id
}
```

```hcl
# Storage Account names must be globally unique.
name = var.storage_account_name
```

### Avoid

```hcl
# Create a Resource Group.
resource "azurerm_resource_group" "backend" {
```

```hcl
# Set the location.
location = var.location
```

---

## Configuration Management

Separate Terraform configuration from environment-specific values.

Terraform configuration defines the desired infrastructure. Environment-specific values should be supplied through variables, local configuration files, or the deployment pipeline.

Examples include:

- Subscription IDs
- Resource names
- Regions
- Environment-specific settings

Avoid hard-coding environment-specific values directly in Terraform configuration.

Follow these patterns consistently:

- Commit example/template files (for example, `terraform.tfvars.example` and `backend.tf.example`).
- Keep environment-specific files local or provide them through the CI/CD pipeline.
- Never commit secrets, credentials, or Terraform state.

---

## Resource References

- When a Terraform resource depends on another managed resource, reference the managed resource rather than repeating its input variables.
- Prefer Terraform resource attributes (for example, `.id` or `.name`) over manually constructing Azure resource identifiers whenever possible.

Referencing managed resources makes dependencies explicit, improves readability, and reduces the risk of configuration drift.

### Good

```hcl
resource_group_name = azurerm_resource_group.backend.name
location            = azurerm_resource_group.backend.location
```

### Avoid

```hcl
resource_group_name = var.resource_group_name
location            = var.location
```

---

## CI/CD Authentication

Prefer passwordless workload identity for CI/CD authentication.

GitHub Actions should authenticate to Azure using Microsoft Entra Workload Identity Federation with OpenID Connect (OIDC) when supported.

Follow these principles:

- Do not use long-lived Azure client secrets when OIDC federation is available.
- Do not use App Service publish profiles as the primary deployment authentication mechanism when Azure RBAC and OIDC can be used.
- Restrict federated trust to the intended GitHub repository and deployment environment.
- Grant deployment identities only the Azure RBAC permissions required for their responsibility.
- Manage workload identity and federated credential infrastructure using Terraform.
- Keep authentication infrastructure independent from application hosting infrastructure when they have separate lifecycles.

---

## Validation & Deployment

Validate infrastructure before deployment.

Every logical change should follow this workflow:

1. Implement the change.
2. Run `terraform fmt`.
3. Run `terraform validate`.
4. Review `terraform plan`.
5. Apply the change with `terraform apply` when appropriate.

Infrastructure should never be applied without reviewing the execution plan.

When introducing a new implementation pattern, validate it with a single representative resource before applying the same pattern more broadly. Once the implementation has been verified and `terraform plan` reports no changes, the pattern may be repeated for similar resources.

---

## Git Workflow

All development should be performed using feature branches.

Recommended workflow:

1. Create a Jira feature.
2. Create a Git feature branch.
3. Update the relevant documentation before implementation.
4. Implement the feature.
5. Validate the Terraform configuration.
6. Commit each meaningful logical change using a clear commit message. Use the Jira feature identifier for feature work and descriptive prefixes (for example, `Docs:`, `Fix:`, or `Refactor:`) for non-feature commits.
7. Push the feature branch to GitHub.
8. Create and review a pull request.
9. Merge the pull request into `main`.
10. Create Git tags for significant project milestones when appropriate.

Commit messages should clearly describe the purpose of the change rather than the files modified.

---

## Jira Workflow

Every feature should be planned before implementation.

Each Jira feature should include:

- **Description** – Explains the purpose of the feature and the problem it solves.
- **Objectives** – Defines the desired outcomes.
- **Acceptance Criteria** – Specifies the conditions required for completion.
- **Technical Notes** *(optional)* – Records implementation decisions, dependencies, or architectural considerations.
- **Out of Scope** *(optional)* – Identifies work intentionally excluded from the feature.

Well-defined Jira features reduce scope creep, improve consistency, and establish clear expectations before implementation begins.

---

## Documentation

Documentation should evolve with the implementation. Architectural decisions, engineering practices, and module documentation should be updated as features are implemented.

The repository should include:

- Project documentation
- Architecture documentation
- Engineering principles
- Module-specific README files

### Module Documentation

Each Terraform root module should include a `README.md`.

Every module README should follow the standard structure:

- Introductory purpose description
- Resources
- Prerequisites
- Deployment
- Terraform State

Module documentation should describe the module's responsibilities, deployment process, and Terraform state management while maintaining a consistent format across the repository.

### Variable Documentation

Terraform variable descriptions should use consistent wording and formatting throughout the repository.

Follow these conventions:

- Capitalize official Azure resource and service names using Microsoft terminology.
- Capitalize Azure Landing Zone subscription names (Management, Connectivity, and Development).
- Use lowercase for general terms that are not official Azure names.
- Use consistent wording for similar variables.
- Prefer concise descriptions that describe the purpose of the variable rather than its implementation.

Examples:

```hcl
description = "Azure subscription ID used for the Management subscription."

description = "Name of the Resource Group used for monitoring resources."

description = "Azure region where monitoring resources are deployed."

description = "Name of the Management subscription Activity Log Diagnostic Setting."
```

### Root Module Initialization

Create new Terraform root modules using the following workflow:

1. Create the module directory.
2. Create the standard Terraform files:
   - `backend.tf.example`
   - `main.tf`
   - `outputs.tf`
   - `providers.tf`
   - `README.md`
   - `terraform.tfvars.example`
   - `variables.tf`
   - `versions.tf`
3. Populate:
   - `README.md`
   - `backend.tf.example`
   - `versions.tf`
   - `providers.tf`
   - `variables.tf`
   - `terraform.tfvars.example`
4. Copy:
   - `backend.tf.example` → `backend.tf`
   - `terraform.tfvars.example` → `terraform.tfvars`
5. Populate the local configuration files with environment-specific values.
6. Initialize the Terraform working directory:

   ```bash
   terraform init
   ```

7. Begin implementing the infrastructure one representative resource or implementation pattern at a time.
8. Validate changes using:

   ```bash
   terraform fmt
   terraform validate
   terraform plan
   ```

This workflow establishes a consistent foundation for every Terraform root module before infrastructure implementation begins.
