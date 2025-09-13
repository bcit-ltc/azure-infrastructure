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
  description = "Azure region for resources."
  type        = string
  default     = "canadacentral"
}

# Optional common tags reused by modules
variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default = {
    project = "infrastructure"
    managed = "terraform"
  }
}
