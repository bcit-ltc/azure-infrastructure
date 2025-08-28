terraform {
  required_version = ">= 1.4.0"

  required_providers {
    azurerm = { source = "hashicorp/azurerm" }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
  # Default: az CLI / environment for auth and subscription
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}
