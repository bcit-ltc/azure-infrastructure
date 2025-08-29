output "container_meta" {
  description = "Container metadata"
  value = {
    name     = azurerm_resource_group.resource-group.name
    location = azurerm_resource_group.resource-group.location
  }
}

output "container_name" {
  value = azurerm_storage_container.storage-container.name
}

output "storage_account_name" {
  value = azurerm_storage_account.storage-account.name
}

output "use_azuread_auth" {
  value = true
}

output "use_cli" {
  value = true
}
