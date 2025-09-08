# Azure Infrastructure

Terraform configuration for Azure blob storage.

## Prerequisites

- Azure CLI
- Terraform

## Terraform state

> [Terraform Docs: azurerm backend block](https://developer.hashicorp.com/terraform/language/backend/azurerm)
> [Azure Docs: Store Terraform state in Azure Storage](https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli)

Create a **resource group**, **storage account**, and **private blob container** using a local state file. Then, migrate it to Azure.

Other services managed by Terraform can use this container for state storage as long as unique keys are used for each state.

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

If you need to re-copy the outputs, run `terraform output`.
```

### Migrate local Terraform state to the newly created Azure storage container

1. Uncomment the Terraform block in `main.tf` and confirm that `terraform output` matches the block's `azurerm` configuration.

1. Migrate the state file to Azure.

```bash
terraform init -migrate-state
```

> Answer the prompt to copy the backend.

## License

This Source Code Form is subject to the terms of the Mozilla Public License, v2.0. If a copy of the MPL was not distributed with this file, You can obtain one at <https://mozilla.org/MPL/2.0/>.

## About

Developed in 🇨🇦 Canada by the [Learning and Teaching Centre](https://www.bcit.ca/learning-teaching-centre/) at [BCIT](https://www.bcit.ca/).
