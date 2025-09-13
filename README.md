# Azure Storage

This project uses a **generic submodule** `modules/storage-bucket` to provision storage containers:

- `module.vault_tfstate` → creates a new Storage Account + a `tfstate` container
- `module.rancher_backup` → creates a new Storage Account + a `rancherbackup` container

Common values (`location`, `resource_group_name`, `tags`) are set once at the root and passed into each module.

## Use

```bash
terraform init
terraform plan -out tfplan
terraform apply "tfplan"
```

## Notes

- Storage Account names get a random 8-char suffix for global uniqueness.

## About

Developed in 🇨🇦 Canada by the [Learning and Teaching Centre](https://www.bcit.ca/learning-teaching-centre/) at [BCIT](https://www.bcit.ca/).
