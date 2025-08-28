# Azure Infra — Phase 2 (Remote Backend + Optional RBAC)

This phase **migrates** local state to the Azure blob container created in Phase 1, then optionally lets you enable RBAC on subsequent applies.

## 1) Create local backend config
```bash
cp backend.hcl.example backend.hcl
# fill values with Phase 1 outputs: storage_account_name, container_name
```

## 2) Migrate local state to Azure (one-time)
```bash
az login
az account set --subscription "<SUBSCRIPTION_ID_OR_NAME>"
terraform init -migrate-state -backend-config=backend.hcl
# (add -force-copy to skip prompt)
```

## 3) Normal usage
```bash
terraform plan
terraform apply
```

## 4) (Optional) Enable RBAC later
- Uncomment the RBAC blocks in `main.tf` and run `terraform apply`.
- To grant additional principals (SPs/workload identities), set `-var='additional_principal_ids=["<OBJECT_ID>", ...]'`.
