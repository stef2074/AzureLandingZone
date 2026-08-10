resource "azuread_application" "jobassistant_github_actions" {
  display_name = var.github_actions_application_name
}