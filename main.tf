terraform {
  backend "azurerm" {
    container_name       = "tfstate"
    storage_account_name = "tfstatez55vivoh"
    use_azuread_auth     = true
    use_cli              = true

    key = "azure-infrastructure/terraform.tfstate"
  }
}

locals {
  common = {
    location            = var.location
    resource_group_name = var.resource_group_name
    tags                = var.tags
  }

  storage_buckets = {
    tfstate = {
      name_prefix    = "tfstate"
      container_name = "tfstate"
    }
    longhorn = {
      name_prefix    = "longhorn"
      container_name = "longhornbackup"
    }
    rancher = {
      name_prefix    = "rancherbk"
      container_name = "rancherbackup"
    }
  }
}

module "resource_group" {
  source = "./modules/resource-group"

  name     = local.common.resource_group_name
  location = local.common.location
  tags     = local.common.tags
}

module "storage_buckets" {
  source   = "./modules/storage-bucket"
  for_each = local.storage_buckets

  location                    = local.common.location
  resource_group_name         = module.resource_group.name
  storage_account_name_prefix = each.value.name_prefix
  container_name              = each.value.container_name
  tags                        = local.common.tags
}

module "common_cdn_storage" {
  source = "./modules/storage-cdn"

  location                    = local.common.location
  resource_group_name         = module.resource_group.name
  storage_account_name_prefix = "commoncdn"
  container_name              = "cdn"
  tags                        = local.common.tags

  cors_allowed_origins = ["*"]

  enable_static_website = false
  static_index_document = "index.html"
  static_error_document = "404.html"
}

module "common_cdn_frontdoor" {
  source = "./modules/frontdoor-cdn"

  resource_group_name  = module.resource_group.name
  profile_name         = "bcit-ltc-commoncdn-afd"
  endpoint_name        = "bcit-ltc-cdn"
  blob_primary_host    = module.common_cdn_storage.primary_blob_host
  storage_account_name = module.common_cdn_storage.storage_account_name
}
