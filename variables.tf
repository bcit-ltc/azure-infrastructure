variable "location" {
  description = "Azure region for the RG and Storage Account."
  type        = string
  default     = "canadacentral"
}

variable "resource_group_name" {
  description = "Resource Group name."
  type        = string
  default     = "vault-tfstate"
}

variable "storage_account_name" {
  description = "Globally-unique Storage Account name (lowercase, 3–24 chars)."
  type        = string
}

variable "container_name" {
  description = "Blob container name."
  type        = string
  default     = "vault-tfstate"
}

# Optional toggles for later applies (RBAC / additional principals)
variable "additional_principal_ids" {
  description = "Optional AAD object IDs (users/SPs/workload identities) to grant Blob Data Owner on the container."
  type        = list(string)
  default     = []
}

variable "grant_reader_on_sa" {
  description = "Also grant Reader on the Storage Account (not usually required)."
  type        = bool
  default     = false
}
