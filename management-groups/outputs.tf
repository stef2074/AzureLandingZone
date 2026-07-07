output "platform_management_group_id" {
  description = "Resource ID of the Platform Management Group."
  value       = azurerm_management_group.platform.id
}

output "management_management_group_id" {
  description = "Resource ID of the Management Management Group."
  value       = azurerm_management_group.management.id
}

output "connectivity_management_group_id" {
  description = "Resource ID of the Connectivity Management Group."
  value       = azurerm_management_group.connectivity.id
}

output "landing_zones_management_group_id" {
  description = "Resource ID of the Landing Zones Management Group."
  value       = azurerm_management_group.landing_zones.id
}

output "development_management_group_id" {
  description = "Resource ID of the Development Management Group."
  value       = azurerm_management_group.development.id
}
