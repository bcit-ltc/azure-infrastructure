variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "storage_account_name_prefix" {
  type        = string
  description = "Prefix for storage account name (will be suffixed with random string)."
}

variable "container_name" {
  type        = string
  description = "Blob container name."
}

variable "tags" {
  type        = map(string)
  default     = {}
}

variable "assign_current_principal" {
  type        = bool
  default     = true
  description = "Assign Storage Blob Data Owner on the container to the current principal."
}

# CORS
variable "cors_allowed_origins" {
  type        = list(string)
  default     = []
  description = "Allowed origins for CORS. Empty list means no CORS rule is set."
}

variable "cors_allowed_methods" {
  type        = list(string)
  default     = ["GET", "HEAD", "OPTIONS"]
}

variable "cors_allowed_headers" {
  type        = list(string)
  default     = ["*"]
}

variable "cors_exposed_headers" {
  type        = list(string)
  default     = ["*"]
}

variable "cors_max_age_seconds" {
  type        = number
  default     = 3600
}

# Static website
variable "enable_static_website" {
  type        = bool
  default     = false
}

variable "static_index_document" {
  type        = string
  default     = "index.html"
}

variable "static_error_document" {
  type        = string
  default     = "404.html"
}
