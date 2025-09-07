# Azure Infrastructure

Terraform configurations for Azure.

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

If you need to re-copy the outputs, run `terraform output`.
```

### Migrate local Terraform state to the newly created Azure storage container

Start by uncommenting the Terraform block in `main.tf`. Confirm that `terraform output` matches the block's `azurerm` configuration.

Next, migrate the state file to Azure.

```bash

terraform init -migrate-state
```

> Answer the prompt to copy the backend.

## License

Copyright (c) 2008-2025 [BCIT LTC](https://www.bcit.ca/learning-teaching-centre/)

This Source Code Form is subject to the terms of the Mozilla Public License, v2.0. If a copy of the MPL was not distributed with this file, You can obtain one at <https://mozilla.org/MPL/2.0/>.

## About

Developed in 🇨🇦 Canada by [BCIT's](https://www.bcit.ca/) [Learning and Teaching Centre](https://www.bcit.ca/learning-teaching-centre/). [Contact Us](mailto:ltc_techops@bcit.ca).
