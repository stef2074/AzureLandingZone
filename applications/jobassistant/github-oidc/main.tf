resource "azuread_application" "jobassistant_github_actions" {
  display_name = var.github_actions_application_name
}

resource "azuread_service_principal" "jobassistant_github_actions" {
  client_id = azuread_application.jobassistant_github_actions.client_id
}