# Azure Infrastructure (Terraform state bootstrap)

Creates the Azure resources for storing Terraform state:
- Resource Group
- Storage Account (Standard LRS)
- Private Blob Container
- RBAC: **Storage Blob Data Owner** on the container for the current caller (+ optional principals)

> This project keeps **local** state. Use it **before** switching other repos (e.g., Vault) to the Azure backend.

## Prerequisites
- Azure CLI installed and logged in to the correct subscription.
- Terraform installed.

## 1) Login & select subscription
```bash
az login
az account set --subscription "<SUBSCRIPTION_NAME_OR_ID>"
```

## 2) Configure variables
Copy the example and set a **globally-unique** storage account name:
```bash
cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars
```

## 3) Init & Apply
```bash
terraform init
terraform apply -auto-approve
```

When done, Terraform prints the backend values:
```txt
backend_config_cli_flags = {
  container_name       = "vault-tfstate"
  key                  = "envs/stable/terraform.vault-tfstate"
  storage_account_name = "tfst1234567890"
}
```

## 4) Use the backend in another repo (e.g., Vault)
In that other repo, either add a backend block:

```hcl
terraform {
  backend "azurerm" {
    use_azuread_auth     = true
    use_cli              = true
    storage_account_name = "tfst1234567890"
    container_name       = "vault-tfstate"
    key                  = "envs/stable/terraform.vault-tfstate"
  }
}
```

…or run `terraform init` with flags (no code change):

```bash
terraform init -reconfigure       -backend-config="use_azuread_auth=true"       -backend-config="use_cli=true"       -backend-config="storage_account_name=tfst1234567890"       -backend-config="container_name=vault-tfstate"       -backend-config="key=envs/stable/terraform.vault-tfstate"
```

> If migrating existing local state in that repo, add `-migrate-state` to the init command.

## Notes
- RBAC propagation can take a few minutes; if your next repo hits 403, wait and retry.
- Once you’re comfortable with AAD-only access, you can set `shared_access_key_enabled = false` in `main.tf` to disable account keys.
