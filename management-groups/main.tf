# Platform

resource "azurerm_management_group" "platform" {
  name                       = "alz-platform"
  display_name               = "Platform"
  parent_management_group_id = var.tenant_root_group_id
}

resource "azurerm_management_group" "management" {
  name         = "alz-platform-management"
  display_name = "Management"

  parent_management_group_id = azurerm_management_group.platform.id
}

resource "azurerm_management_group" "connectivity" {
  name         = "alz-platform-connectivity"
  display_name = "Connectivity"

  parent_management_group_id = azurerm_management_group.platform.id
}

# Landing Zones

resource "azurerm_management_group" "landing_zones" {
  name                       = "alz-landing-zones"
  display_name               = "Landing Zones"
  parent_management_group_id = var.tenant_root_group_id
}

resource "azurerm_management_group" "development" {
  name         = "alz-landing-zones-development"
  display_name = "Development"

  parent_management_group_id = azurerm_management_group.landing_zones.id
}


