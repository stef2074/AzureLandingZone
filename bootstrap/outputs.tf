output "resource_group_name" {
  description = "Terraform backend Resource Group name."
  value       = azurerm_resource_group.backend.name
}

output "storage_account_name" {
  description = "Terraform backend Storage Account name."
  value       = azurerm_storage_account.backend.name
}

output "container_name" {
  description = "Terraform backend Blob Container name."
  value       = azurerm_storage_container.backend.name
}
