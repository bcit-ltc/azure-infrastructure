# Look up current principal (for optional RBAC)
data "azurerm_client_config" "current" {}

# Resource Group (reference existing)
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# Random suffix for globally-unique Storage Account name
resource "random_string" "sa" {
  length  = 8
  lower   = true
  upper   = false
  numeric = true
  special = false
}

# Storage Account
resource "azurerm_storage_account" "sa" {
  name                        = lower(substr("${var.storage_account_name_prefix}${random_string.sa.result}", 0, 24))
  resource_group_name         = data.azurerm_resource_group.rg.name
  location                    = data.azurerm_resource_group.rg.location
  account_tier                = "Standard"
  account_replication_type    = "LRS"
  min_tls_version             = "TLS1_2"

  # Keep parameters aligned with existing files; do not add extras.
  blob_properties {
    versioning_enabled = true
  }

  tags = var.tags
}

# Blob Container
resource "azurerm_storage_container" "container" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.sa.id
  container_access_type = "private"
}

# Optional RBAC on the container for current principal
resource "azurerm_role_assignment" "container_owner_self" {
  count                = var.assign_current_principal ? 1 : 0
  scope                = "${azurerm_storage_account.sa.id}/blobServices/default/containers/${azurerm_storage_container.container.name}"
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azurerm_client_config.current.object_id
}
