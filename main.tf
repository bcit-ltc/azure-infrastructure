resource "azurerm_resource_group" "vault-tfstate" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "vault-tfstate" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.vault-tfstate.name
  location                 = azurerm_resource_group.vault-tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
}

resource "azurerm_storage_container" "vault-tfstate" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.vault-tfstate.id
  container_access_type = "private"
}

data "azurerm_client_config" "current" {}

locals {
  container_scope = "${azurerm_storage_account.vault-tfstate.id}/blobServices/default/containers/${azurerm_storage_container.vault-tfstate.name}"
}

resource "azurerm_role_assignment" "blob_owner_self" {
  scope                = local.container_scope
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "blob_owner_extra" {
  for_each             = toset(var.additional_principal_ids)
  scope                = local.container_scope
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "reader_on_sa" {
  count                = var.grant_reader_on_sa ? 1 : 0
  scope                = azurerm_storage_account.vault-tfstate.id
  role_definition_name = "Reader"
  principal_id         = data.azurerm_client_config.current.object_id
}

# terraform {
#   backend "azurerm" {}
# }