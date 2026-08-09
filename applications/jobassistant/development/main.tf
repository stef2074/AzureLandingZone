resource "azurerm_resource_group" "jobassistant" {
  name     = var.resource_group_name
  location = var.location
}