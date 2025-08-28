output "backend_config_cli_flags" {
  description = "Use these with `terraform init -backend-config=...` in `vault-infrastructure` repo."
  value = {
    storage_account_name = azurerm_storage_account.vault-tfstate.name
    container_name       = azurerm_storage_container.vault-tfstate.name
    key                  = var.state_key
  }
}

output "ids" {
  value = {
    resource_group  = azurerm_resource_group.vault-tfstate.id
    storage_account = azurerm_storage_account.vault-tfstate.id
    container_scope = local.container_scope
  }
}
