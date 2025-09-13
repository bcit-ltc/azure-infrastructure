output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "Resource Group used"
}

output "location" {
  value       = azurerm_resource_group.rg.location
  description = "Azure region"
}

output "storage_account_name" {
  value       = azurerm_storage_account.sa.name
  description = "New Storage Account name"
}

output "container_name" {
  value       = azurerm_storage_container.container.name
  description = "Blob container name"
}

output "container_scope" {
  value       = "${azurerm_storage_account.sa.id}/blobServices/default/containers/${azurerm_storage_container.container.name}"
  description = "ARM scope for the container (useful for RBAC assignments)"
}
