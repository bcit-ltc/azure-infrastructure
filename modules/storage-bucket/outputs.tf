output "resource_group_name" {
  value       = data.azurerm_resource_group.rg.name
  description = "Resource Group used"
}

output "location" {
  value       = data.azurerm_resource_group.rg.location
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

output "storage_account_key" {
  value       = azurerm_storage_account.sa.primary_access_key
  description = "Primary access key for the storage account"
  sensitive   = true
}

output "storage_connection_string" {
  value       = azurerm_storage_account.sa.primary_connection_string
  description = "Primary connection string for the storage account"
  sensitive   = true
}

output "blob_endpoint" {
  value       = azurerm_storage_account.sa.primary_blob_endpoint
  description = "Primary blob endpoint URL"
}

output "container_url" {
  value       = "${azurerm_storage_account.sa.primary_blob_endpoint}${azurerm_storage_container.container.name}"
  description = "Full URL to the blob container"
}
