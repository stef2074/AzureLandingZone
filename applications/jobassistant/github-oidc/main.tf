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