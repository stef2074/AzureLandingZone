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

resource "azurerm_linux_web_app" "jobassistant" {
  name                = var.app_service_name
  resource_group_name = azurerm_resource_group.jobassistant.name
  location            = azurerm_resource_group.jobassistant.location
  service_plan_id     = azurerm_service_plan.jobassistant.id


  site_config {
    always_on = false

    application_stack {
      dotnet_version = var.app_service_dotnet_version
    }
  }
}