variable "location" {
  description = "Azure region for the RG and Storage Account."
  type        = string
  default     = "canadacentral"
}

variable "resource_group_name" {
  description = "Resource Group name for Terraform state."
  type        = string
  default     = "vault-tfstate"
}

variable "storage_account_name" {
  description = "Globally-unique Storage Account name (lowercase letters/numbers only)."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "storage_account_name must be 3–24 chars of lowercase letters and numbers."
  }
}

variable "container_name" {
  description = "Blob container name for the state."
  type        = string
  default     = "vault-tfstate"
}

variable "state_key" {
  description = "Blob name (path) for this workspace's state file."
  type        = string
  default     = "envs/stable/terraform.vault-tfstate"
}

variable "grant_reader_on_sa" {
  description = "Also grant Reader on the Storage Account (needed only if you use lookup_blob_endpoint)."
  type        = bool
  default     = false
}

variable "additional_principal_ids" {
  description = "Optional list of AAD object IDs (users/SPs/workload identities) to grant Blob Data Owner on the container."
  type        = list(string)
  default     = []
}

variable "subscription_id" {
  description = "The subscription ID to use."
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID to use."
  type        = string
}
