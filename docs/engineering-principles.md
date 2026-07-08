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
# Storage account names must be globally unique.
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
3. Implement the feature.
4. Validate the Terraform configuration.
5. Commit using meaningful commit messages that clearly describe the purpose of the change. Use the Jira feature identifier for feature work and descriptive prefixes (for example, `Docs:`, `Fix:`, or `Refactor:`) for non-feature commits.
6. Merge into `main`.
7. Push changes to GitHub.
8. Create Git tags for significant project milestones.

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

- Purpose
- Resources
- Prerequisites
- Deployment
- Terraform State

Module documentation should describe the module's responsibilities, deployment process, and Terraform state management while maintaining a consistent format across the repository.
