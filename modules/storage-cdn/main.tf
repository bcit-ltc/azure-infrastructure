terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "random_string" "sa" {
  length  = 8
  lower   = true
  upper   = false
  numeric = true
  special = false
}

resource "azurerm_storage_account" "sa" {
  name                     = lower(substr("${var.storage_account_name_prefix}${random_string.sa.result}", 0, 24))
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  blob_properties {
    versioning_enabled = true

    dynamic "cors_rule" {
      for_each = length(var.cors_allowed_origins) > 0 ? [1] : []
      content {
        allowed_origins    = var.cors_allowed_origins
        allowed_methods    = var.cors_allowed_methods
        allowed_headers    = var.cors_allowed_headers
        exposed_headers    = var.cors_exposed_headers
        max_age_in_seconds = var.cors_max_age_seconds
      }
    }
  }

  tags = var.tags
}

resource "azurerm_storage_container" "container" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.sa.id
  container_access_type = "blob"
}

resource "azurerm_role_assignment" "container_owner_self" {
  count                = var.assign_current_principal ? 1 : 0
  scope                = "${azurerm_storage_account.sa.id}/blobServices/default/containers/${azurerm_storage_container.container.name}"
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_storage_account_static_website" "this" {
  count             = var.enable_static_website ? 1 : 0
  storage_account_id = azurerm_storage_account.sa.id

  index_document     = var.static_index_document
  error_404_document = var.static_error_document
}

