terraform {
  required_version = ">= 1.4.0"
  required_providers {
    azurerm = { source = "hashicorp/azurerm" }
  }
}

# Auth & subscription come from Azure CLI: run `az login` and `az account set --subscription "<SUBSCRIPTION_ID_OR_NAME>"`
provider "azurerm" {
  features {}
}
