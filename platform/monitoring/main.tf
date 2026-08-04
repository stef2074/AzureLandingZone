resource "azurerm_resource_group" "monitoring" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_log_analytics_workspace" "monitoring" {
  name                = var.log_analytics_workspace_name
  location            = azurerm_resource_group.monitoring.location
  resource_group_name = azurerm_resource_group.monitoring.name
  sku                 = var.log_analytics_workspace_sku
  retention_in_days   = var.log_analytics_workspace_retention_in_days
}

data "azurerm_subscription" "management" {
  subscription_id = var.management_subscription_id
}

resource "azurerm_monitor_diagnostic_setting" "management_activity_log" {
  name                       = var.management_activity_log_diagnostic_setting_name
  target_resource_id         = data.azurerm_subscription.management.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.monitoring.id

  enabled_log {
    category_group = "allLogs"
  }
}