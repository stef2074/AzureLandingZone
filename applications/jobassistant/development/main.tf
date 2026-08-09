resource "azurerm_resource_group" "jobassistant" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_service_plan" "jobassistant" {
  name                = var.app_service_plan_name
  resource_group_name = azurerm_resource_group.jobassistant.name
  location            = azurerm_resource_group.jobassistant.location
  os_type             = var.app_service_plan_os_type
  sku_name            = var.app_service_plan_sku_name
}