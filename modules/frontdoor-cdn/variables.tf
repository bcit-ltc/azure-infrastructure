variable "resource_group_name" {}
variable "profile_name" {}
variable "endpoint_name" {}
variable "blob_primary_host" {} # output from storage-cdn module

variable "storage_account_name" {
	description = "Storage Account name for CDN blob origin."
}
