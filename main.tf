# Caller identity (for RBAC)
data "azurerm_client_config" "current" {}

# Resource Group
resource "azurerm_resource_group" "vault-tfstate" {
  name     = var.resource_group_name
  location = var.location
}

# Storage Account (standard LRS, TLS 1.2, no public containers)
resource "azurerm_storage_account" "vault-tfstate" {
  name                              = var.storage_account_name
  resource_group_name               = azurerm_resource_group.vault-tfstate.name
  location                          = azurerm_resource_group.vault-tfstate.location
  account_tier                      = "Standard"
  account_replication_type          = "LRS"
  min_tls_version                   = "TLS1_2"
  shared_access_key_enabled         = true          # set false later if you enforce AAD-only
  infrastructure_encryption_enabled = true

  blob_properties {}
}

# Private container for vault-tfstate
resource "azurerm_storage_container" "vault-tfstate" {
  name                  = var.container_name
  storage_account_id  = azurerm_storage_account.vault-tfstate.id
  container_access_type = "private"
}

# Container-scope RBAC
locals {
  container_scope = "${azurerm_storage_account.vault-tfstate.id}/blobServices/default/containers/${azurerm_storage_container.vault-tfstate.name}"
}

# Give the current caller Blob Data Owner on the container
resource "azurerm_role_assignment" "blob_owner_self" {
  scope                = local.container_scope
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azurerm_client_config.current.object_id
}

# Grant additional principals (SPs, workload identities, teammates) - see terraform.tfvars
resource "azurerm_role_assignment" "blob_owner_extra" {
  for_each             = toset(var.additional_principal_ids)
  scope                = local.container_scope
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = each.value
}

# Grant Reader on the Storage Account
resource "azurerm_role_assignment" "reader_on_sa" {
  count                = var.grant_reader_on_sa ? 1 : 0
  scope                = azurerm_storage_account.vault-tfstate.id
  role_definition_name = "Reader"
  principal_id         = data.azurerm_client_config.current.object_id
}
