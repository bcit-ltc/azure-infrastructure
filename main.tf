resource "azurerm_resource_group" "resource-group" {
  name     = var.resource_group_name
  location = var.location
}

# Globally-unique Storage Account name (lowercase, 3–24 chars)
resource "azurerm_storage_account" "storage-account" {
  name                     = "tfstate21402"
  resource_group_name      = azurerm_resource_group.resource-group.name
  location                 = azurerm_resource_group.resource-group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
}

resource "azurerm_storage_container" "storage-container" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.storage-account.id
  container_access_type = "private"
}

# Who is running (for RBAC)
data "azurerm_client_config" "current" {}

# RBAC at the container scope
locals {
  container_scope = "${azurerm_storage_account.storage-account.id}/blobServices/default/containers/${azurerm_storage_container.storage-container.name}"
}

resource "azurerm_role_assignment" "blob_owner_self" {
  scope                = local.container_scope
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azurerm_client_config.current.object_id
}

output "key" {
  description = "The key for the backend state file. Should match backend configuration."
  value = "azure-infrastructure.tfstate"
}

# This block should be commented for the first `terraform init` (create a local state), and be uncommented when state is to be migrated to Azure
#
terraform {
  backend "azurerm" {
    container_name = "tfstate"
    key = "azure-infrastructure.tfstate"
    storage_account_name = "tfstate21402"
    use_azuread_auth = true
    use_cli = true
  }  
}
