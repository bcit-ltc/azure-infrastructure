# Azure Infrastructure

## Prerequisites

- Azure CLI
- Terraform

## Store Terraform state in Azure

> [Terraform Docs: azurerm backend block](https://developer.hashicorp.com/terraform/language/backend/azurerm)
> [Azure Docs: Store Terraform state in Azure Storage](https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli)

Create the **resource group**, **storage account**, and **private blob container** using the local backend, then, migrate it to Azure.

Other services managed by Terraform can use this container as state storage; use unique state keys for each service.

### Create an Azure storage container with local Terraform state

```bash
az login

# Set environment variables
export TF_VAR_tenant_id=$(az account show --query tenantId -o tsv)
export TF_VAR_subscription_id=$(az account show --query id -o tsv)

# Initialize the project
terraform init
terraform apply

# Note the outputs printed: storage_account_name, container_name, key
```

### Migrate local Terraform state to the newly created Azure storage container

Start by uncommenting the Terraform block in `main.tf`. Confirm that `terraform output` matches the block's `azurerm` configuration.

Next, migrate the state file to Azure.

```bash

terraform init -migrate-state
```

> Answer the prompt to copy the backend.
