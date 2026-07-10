resource "azurerm_resource_group" "connectivity" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "hub" {
  name                = var.virtual_network_name
  location            = azurerm_resource_group.connectivity.location
  resource_group_name = azurerm_resource_group.connectivity.name

  address_space = [
    var.virtual_network_address_space
  ]
}

resource "azurerm_subnet" "gateway" {
  name                 = var.gateway_subnet_name
  resource_group_name  = azurerm_resource_group.connectivity.name
  virtual_network_name = azurerm_virtual_network.hub.name

  address_prefixes = [
    var.gateway_subnet_address_prefix
  ]
}

resource "azurerm_subnet" "shared_services" {
  name                 = var.shared_services_subnet_name
  resource_group_name  = azurerm_resource_group.connectivity.name
  virtual_network_name = azurerm_virtual_network.hub.name

  address_prefixes = [
    var.shared_services_subnet_address_prefix
  ]
}

resource "azurerm_network_security_group" "shared_services" {
  name                = var.network_security_group_name
  location            = azurerm_resource_group.connectivity.location
  resource_group_name = azurerm_resource_group.connectivity.name
}

resource "azurerm_route_table" "shared_services" {
  name                = var.route_table_name
  location            = azurerm_resource_group.connectivity.location
  resource_group_name = azurerm_resource_group.connectivity.name
}

resource "azurerm_subnet_network_security_group_association" "shared_services" {
  subnet_id                 = azurerm_subnet.shared_services.id
  network_security_group_id = azurerm_network_security_group.shared_services.id
}

resource "azurerm_subnet_route_table_association" "shared_services" {
  subnet_id      = azurerm_subnet.shared_services.id
  route_table_id = azurerm_route_table.shared_services.id
}
