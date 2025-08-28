# Azure Infra — Phase 1 (Local State, Minimal HCL)

This phase creates the **resource group**, **storage account**, and a **private blob container** using the local backend.

## Use
```bash
az login
az account set --subscription "<SUBSCRIPTION_ID_OR_NAME>"

# set variables (example)
export TF_VAR_storage_account_name="tfst$(date +%s)"
export TF_VAR_container_name="tfstate"
# or create a terraform.tfvars with those values

terraform init
terraform apply -auto-approve
# note the outputs printed: storage_account_name, container_name, key
```

Proceed to **Phase 2** to migrate state to this container.
