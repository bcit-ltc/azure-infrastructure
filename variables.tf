variable "location" {
  description = "Azure region for the RG and Storage Account."
  type        = string
  default     = "canadacentral"
}

variable "resource_group_name" {
  description = "Resource Group name."
  type        = string
  default     = "rg-tfstate"
}

variable "storage_account_name" {
  description = "Globally-unique Storage Account name (lowercase, 3–24 chars)."
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "storage_account_name must be 3–24 chars of lowercase letters and numbers."
  }
}

variable "container_name" {
  description = "Blob container name (lowercase letters, numbers, and hyphens)."
  type        = string
  default     = "tfstate"
  validation {
    condition     = can(regex("^[a-z0-9](?:[a-z0-9-]{1,61}[a-z0-9])?$", var.container_name))
    error_message = "container_name must be 3–63 chars, lowercase letters, numbers, hyphens; start/end alphanumeric."
  }
}
