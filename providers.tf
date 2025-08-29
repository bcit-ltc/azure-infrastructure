# Auth & subscription come from Azure CLI
#  - run `az login` and `az account set --subscription "<SUBSCRIPTION_ID_OR_NAME>"`
#  - also set environment variables:
#       export TF_VAR_tenant_id=$(az account show --query tenantId -o tsv)
#       export TF_VAR_subscription_id=$(az account show --query id -o tsv)
provider "azurerm" {
  features {}
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}