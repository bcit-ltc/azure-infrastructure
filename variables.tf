variable "tenant_id" {
  description = "The Tenant ID for the Azure subscription."
  type        = string
}

variable "subscription_id" {
  description = "The Subscription ID for the Azure subscription."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name."
  type        = string
  default     = "terraform"
}

variable "location" {
  description = "Azure region for the RG and Storage Account."
  type        = string
  default     = "canadacentral"
}

variable "container_name" {
  description = "Blob container name (lowercase letters, numbers, and hyphens)."
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9](?:[a-z0-9-]{1,61}[a-z0-9])?$", var.container_name))
    error_message = "container_name must be 3–63 chars, lowercase letters, numbers, hyphens; start/end alphanumeric."
  }
  default     = "tfstate"
}
