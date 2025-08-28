output "backend_values" {
  description = "Backend values."
  value = {
    storage_account_name = azurerm_storage_account.vault-tfstate.name
    container_name       = azurerm_storage_container.vault-tfstate.name
    key                  = "terraform.vault-tfstate"
  }
}
