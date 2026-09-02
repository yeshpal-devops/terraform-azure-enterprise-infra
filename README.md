# Terraform Azure Enterprise Infrastructure

Modular, multi-environment Azure Infrastructure as Code built with Terraform.

## What this project demonstrates

- Reusable Terraform modules
- Environment separation for Dev and Prod
- Azure networking and security controls
- Azure Bastion and Linux virtual machines
- Key Vault-backed VM and SQL credentials
- Azure SQL, Storage, ACR and AKS infrastructure
- Remote-state-ready Terraform workflow
- Secure secret injection for CI/CD

## Project structure

```text
Environment/
  Dev/
  Prod/
Modules/
  azurerm_resource_group/
  azurerm_virtual_network/
  azurerm_network_interface/
  azurerm_public_ip/
  azurerm_key_vault/
  azurerm_virtual_machine/
  azurerm_bastion_host/
  azurerm_mssql_server/
  azurerm_mssql_database/
  azurerm_storage_account/
  azurerm_container_registry/
  azurerm_kubernetes_cluster/
```

## Security

No passwords are stored in the tracked Dev `.tfvars` file. Sensitive values are supplied through Terraform variables:

```text
TF_VAR_vm_1_password
TF_VAR_vm_2_password
TF_VAR_sql_admin_password
```

Use a CI/CD secret store or local environment variables. Protect Terraform state because sensitive values can still be present in state.

> If the previously committed passwords were real credentials, rotate/revoke them. Removing them from the latest file does not remove them from Git history.

## Terraform workflow

```bash
cd Environment/Dev
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

## Production

The `Environment/Prod` directory is reserved for environment-specific production configuration. Before applying it, configure its provider, backend, variables and resource inputs independently from Dev. Do not reuse Dev credentials or state.
