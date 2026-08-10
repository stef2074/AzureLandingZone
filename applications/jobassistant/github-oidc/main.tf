resource "azuread_application" "jobassistant_github_actions" {
  display_name = var.github_actions_application_name
}

resource "azuread_service_principal" "jobassistant_github_actions" {
  client_id = azuread_application.jobassistant_github_actions.client_id
}

resource "azuread_application_federated_identity_credential" "jobassistant_github_actions" {
  application_id = azuread_application.jobassistant_github_actions.id
  display_name   = "github-development"
  description    = "GitHub Actions OIDC federation for the JobAssistant development environment."
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:${var.github_repository_owner}/${var.github_repository_name}:environment:${var.github_environment_name}"
}

data "azurerm_resource_group" "jobassistant" {
  name = var.jobassistant_resource_group_name
}

resource "azurerm_role_assignment" "jobassistant_github_actions" {
  scope                = data.azurerm_resource_group.jobassistant.id
  role_definition_name = "Website Contributor"
  principal_id         = azuread_service_principal.jobassistant_github_actions.object_id
}