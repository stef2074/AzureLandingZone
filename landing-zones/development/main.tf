data "azurerm_virtual_network" "hub" {
  provider = azurerm.connectivity

  name                = var.hub_virtual_network_name
  resource_group_name = var.connectivity_resource_group_name
}

resource "azurerm_resource_group" "development" {
  name     = var.resource_group_name
  location = var.location
}