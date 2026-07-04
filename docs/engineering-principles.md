# Engineering Principles

This document defines the engineering standards used throughout the Azure Landing Zone project. These principles are intended to promote consistency, readability, maintainability, and long-term sustainability.

Engineering principles describe **how** infrastructure is built. Architectural decisions are documented separately in `architecture.md`.

---

# Comments

Comments should explain **why**, not **what**.

Prefer comments that document:

- Architectural decisions
- Design rationale
- Assumptions
- Constraints
- Non-obvious behavior

Avoid comments that merely restate what the Terraform configuration already expresses.

Good comments provide context that cannot be inferred directly from the code.

## Good Examples

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

## Avoid

```hcl
# Create a Resource Group.
resource "azurerm_resource_group" "backend" {
```

```hcl
# Set the location.
location = var.location
```

# Configuration

Separate Terraform configuration from environment-specific values.

Terraform configuration should define the infrastructure to be deployed.
Environment-specific values should be supplied through variables.

Examples include:

- Subscription IDs
- Resource names
- Regions
- Environment-specific settings

Avoid hard-coding environment-specific values directly in Terraform configuration.

# Resource References

When a Terraform resource depends on another managed resource, reference the managed resource rather than repeating its input variables.

Good:

```hcl
resource_group_name = azurerm_resource_group.backend.name
location            = azurerm_resource_group.backend.location
```

Avoid:

```hcl
resource_group_name = var.resource_group_name
location            = var.location
```

Referencing managed resources makes dependencies explicit, improves readability, and reduces the risk of configuration drift.

# Validation

Validate infrastructure before deployment.

Every logical change should follow this workflow:

1. Write
2. terraform fmt
3. terraform validate
4. terraform plan
5. terraform apply

Infrastructure should never be applied without first reviewing the execution plan.
