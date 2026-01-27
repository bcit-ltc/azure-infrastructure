output "vault_tfstate" {
  description = "Vault Terraform state storage details"
  value = {
    resource_group_name  = module.vault_tfstate.resource_group_name
    location             = module.vault_tfstate.location
    storage_account_name = module.vault_tfstate.storage_account_name
    container_name       = module.vault_tfstate.container_name
    container_scope      = module.vault_tfstate.container_scope
  }
}

output "rancher_backup" {
  description = "Rancher backup storage details"
  value = {
    resource_group_name       = module.rancher_backup.resource_group_name
    location                  = module.rancher_backup.location
    storage_account_name      = module.rancher_backup.storage_account_name
    container_name            = module.rancher_backup.container_name
    container_scope           = module.rancher_backup.container_scope
    storage_account_key       = module.rancher_backup.storage_account_key
    storage_connection_string = module.rancher_backup.storage_connection_string
    blob_endpoint             = module.rancher_backup.blob_endpoint
    container_url             = module.rancher_backup.container_url
  }
  sensitive = true
}

output "longhorn_backup" {
  description = "Longhorn backup storage details"
  value = {
    resource_group_name       = module.longhorn_backup.resource_group_name
    location                  = module.longhorn_backup.location
    storage_account_name      = module.longhorn_backup.storage_account_name
    container_name            = module.longhorn_backup.container_name
    container_scope           = module.longhorn_backup.container_scope
    storage_account_key       = module.longhorn_backup.storage_account_key
    storage_connection_string = module.longhorn_backup.storage_connection_string
    blob_endpoint             = module.longhorn_backup.blob_endpoint
    container_url             = module.longhorn_backup.container_url
  }
  sensitive = true
}

output "cdn_frontdoor" {
  value = {
    resource_group_name  = module.common_cdn_frontdoor.resource_group_name
    storage_account_name = module.common_cdn_frontdoor.storage_account_name
    container_name       = module.common_cdn_frontdoor.container_name
    endpoint_url         = module.common_cdn_frontdoor.endpoint_hostname
  }
}
