output "vault_tfstate" {
  description = "Vault Terraform state storage details"
  value = {
    resource_group_name  = module.storage_buckets["tfstate"].resource_group_name
    location             = module.storage_buckets["tfstate"].location
    storage_account_name = module.storage_buckets["tfstate"].storage_account_name
    container_name       = module.storage_buckets["tfstate"].container_name
    container_scope      = module.storage_buckets["tfstate"].container_scope
  }
}

output "rancher_backup" {
  description = "Rancher backup storage details"
  value = {
    resource_group_name       = module.storage_buckets["rancher"].resource_group_name
    location                  = module.storage_buckets["rancher"].location
    storage_account_name      = module.storage_buckets["rancher"].storage_account_name
    container_name            = module.storage_buckets["rancher"].container_name
    container_scope           = module.storage_buckets["rancher"].container_scope
    storage_account_key       = module.storage_buckets["rancher"].storage_account_key
    storage_connection_string = module.storage_buckets["rancher"].storage_connection_string
    blob_endpoint             = module.storage_buckets["rancher"].blob_endpoint
    container_url             = module.storage_buckets["rancher"].container_url
  }
  sensitive = true
}

output "longhorn_backup" {
  description = "Longhorn backup storage details"
  value = {
    resource_group_name       = module.storage_buckets["longhorn"].resource_group_name
    location                  = module.storage_buckets["longhorn"].location
    storage_account_name      = module.storage_buckets["longhorn"].storage_account_name
    container_name            = module.storage_buckets["longhorn"].container_name
    container_scope           = module.storage_buckets["longhorn"].container_scope
    storage_account_key       = module.storage_buckets["longhorn"].storage_account_key
    storage_connection_string = module.storage_buckets["longhorn"].storage_connection_string
    blob_endpoint             = module.storage_buckets["longhorn"].blob_endpoint
    container_url             = module.storage_buckets["longhorn"].container_url
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
