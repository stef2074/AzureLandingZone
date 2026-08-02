data "azurerm_virtual_network" "hub" {
  provider = azurerm.connectivity

  name                = var.hub_virtual_network_name
  resource_group_name = var.connectivity_resource_group_name
}

resource "azurerm_resource_group" "development" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "development" {
  name                = var.virtual_network_name
  address_space       = [var.virtual_network_address_space]
  location            = azurerm_resource_group.development.location
  resource_group_name = azurerm_resource_group.development.name
}

resource "azurerm_subnet" "development" {
  name                 = var.development_subnet_name
  resource_group_name  = azurerm_resource_group.development.name
  virtual_network_name = azurerm_virtual_network.development.name
  address_prefixes     = [var.development_subnet_address_prefix]
}

resource "azurerm_network_security_group" "development" {
  name                = var.network_security_group_name
  location            = azurerm_resource_group.development.location
  resource_group_name = azurerm_resource_group.development.name
}

resource "azurerm_route_table" "development" {
  name                = var.route_table_name
  location            = azurerm_resource_group.development.location
  resource_group_name = azurerm_resource_group.development.name
}