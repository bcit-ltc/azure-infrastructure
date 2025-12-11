terraform {
  backend "azurerm" {
    container_name       = "rancherbackup"
    storage_account_name = "rancherbki0sz5wd3"
    use_azuread_auth     = true
    use_cli              = true
  }
}

locals {
  common = {
    location            = var.location
    resource_group_name = var.resource_group_name
    tags                = var.tags
  }
}

module "vault_tfstate" {
  source = "./modules/storage-bucket"

  location                    = local.common.location
  resource_group_name         = local.common.resource_group_name
  storage_account_name_prefix = "tfstate"
  container_name              = "tfstate"
  tags                        = local.common.tags
}

module "rancher_backup" {
  source = "./modules/storage-bucket"

  location                    = local.common.location
  resource_group_name         = local.common.resource_group_name
  storage_account_name_prefix = "rancherbk"
  container_name              = "rancherbackup"
  tags                        = local.common.tags
}

module "common_cdn_storage" {
  source = "./modules/storage-cdn"

  location                    = local.common.location
  resource_group_name         = local.common.resource_group_name
  storage_account_name_prefix = "commoncdn"
  container_name              = "cdn"
  tags                        = local.common.tags

  cors_allowed_origins        = ["*"]

  enable_static_website       = false
  static_index_document       = "index.html"
  static_error_document       = "404.html"
}

module "common_cdn_frontdoor" {
  source = "./modules/frontdoor-cdn"

  resource_group_name = local.common.resource_group_name
  profile_name        = "bcit-ltc-commoncdn-afd"
  endpoint_name       = "bcit-ltc-cdn"
  blob_primary_host   = module.common_cdn_storage.primary_blob_host
  storage_account_name = module.common_cdn_storage.storage_account_name
}

