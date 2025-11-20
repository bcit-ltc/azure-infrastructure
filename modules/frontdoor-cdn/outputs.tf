output "endpoint_hostname" {
  description = "Public CDN host name (Front Door endpoint)"
  value       = azurerm_cdn_frontdoor_endpoint.this.host_name
}

output "resource_group_name" {
  description = "Resource Group used by Front Door"
  value       = var.resource_group_name
}

output "storage_account_name" {
  description = "Storage Account name used for CDN blob origin"
  value       = var.storage_account_name
}

output "container_name" {
  description = "Container name used for CDN blob origin (if available)"
  value       = "cdn"
}
