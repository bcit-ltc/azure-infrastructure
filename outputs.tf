output "vault_tfstate" {
  description = "Vault Terraform state storage details"
  value = {
    resource_group_name = module.vault_tfstate.resource_group_name
    location            = module.vault_tfstate.location
    storage_account_name= module.vault_tfstate.storage_account_name
    container_name      = module.vault_tfstate.container_name
    container_scope     = module.vault_tfstate.container_scope
  }
}

output "rancher_backup" {
  description = "Rancher backup storage details"
  value = {
    resource_group_name = module.rancher_backup.resource_group_name
    location            = module.rancher_backup.location
    storage_account_name= module.rancher_backup.storage_account_name
    container_name      = module.rancher_backup.container_name
    container_scope     = module.rancher_backup.container_scope
  }
}
