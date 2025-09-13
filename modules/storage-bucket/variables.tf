variable "location" {
  description = "Azure region for the new resources"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name to create/use for the storage account"
  type        = string
}

variable "storage_account_name_prefix" {
  description = "Prefix for the new Storage Account name (lowercase letters/numbers only)"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9]{3,20}$", var.storage_account_name_prefix))
    error_message = "Prefix must be 3-20 chars, lowercase letters or numbers only."
  }
}

variable "container_name" {
  description = "Blob container name to create"
  type        = string
}

variable "assign_current_principal" {
  description = "Grant the current principal (you) Storage Blob Data Owner on the container"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
