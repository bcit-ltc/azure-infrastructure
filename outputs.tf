output "backend_values" {
  description = "Use these values to configure the Azure backend in Phase 2."
  value = {
    storage_account_name = azurerm_storage_account.state.name
    container_name       = azurerm_storage_container.state.name
    key                  = "terraform.tfstate"
  }
}
