terraform {
  backend "azurerm" {
    container_name = "rancherbackup"
    # blob key = rancher
    storage_account_name = "rancherbki0sz5wd3"
    use_azuread_auth = true
    use_cli = true
  }
}

# Common values
locals {
  common = {
    location            = var.location
    resource_group_name = var.resource_group_name
    tags                = var.tags
  }
}

# Module: Vault Terraform state storage
module "vault_tfstate" {
  source = "./modules/storage-bucket"

  location                 = local.common.location
  resource_group_name      = local.common.resource_group_name
  storage_account_name_prefix = "tfstate"
  container_name           = "tfstate"
  tags                     = local.common.tags
}

# Module: Rancher backup storage
module "rancher_backup" {
  source = "./modules/storage-bucket"

  location                 = local.common.location
  resource_group_name      = local.common.resource_group_name
  storage_account_name_prefix = "rancherbk"
  container_name           = "rancherbackup"
  tags                     = local.common.tags
}
