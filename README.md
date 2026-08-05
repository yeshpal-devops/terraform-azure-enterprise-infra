# Terraform Azure Enterprise Infrastructure

Modular, multi-environment Azure Infrastructure as Code built with Terraform, deployed via an Azure DevOps CI/CD pipeline.

This is a personal project built to design and practice production-style Terraform architecture — reusable modules, environment separation, and pipeline-driven deployment.

---

## What this project demonstrates

- **Modular Terraform design** — infrastructure broken into reusable modules instead of one large configuration file
- **Multi-environment separation** — isolated Dev and Prod configurations, each with their own variable inputs
- **Azure DevOps CI/CD pipeline** — automated `terraform init / plan / apply` flow defined in `azure-pipelines.yml`
- **Version-controlled infrastructure** — every change tracked, reviewable, and repeatable through Git

> ⚠️ Edit note: Fill in the exact resource types below to match what's actually inside `/Modules` — remove anything not present. Don't list AKS, ACR, SQL, etc. unless those module folders genuinely exist in the repo.

## Modules

| Module | Description |
|---|---|
| `resource-group` | Provisions the Azure Resource Group container for all resources |
| `vnet` | Virtual Network and subnet configuration |
| `nsg` | Network Security Group rules |
| `key-vault` | Azure Key Vault for secrets management |
| *(add/remove rows to match actual `/Modules` folder contents)* | |

## Environments

```
Environment/
├── Dev/     → development environment variable values
└── Prod/    → production environment variable values
```

Each environment references the shared modules above with environment-specific variable values (`.tfvars`), so the same module code deploys consistently across both without duplication.

## CI/CD Pipeline

`azure-pipelines.yml` defines the automated deployment flow:

```
Code pushed to repo
        ↓
Azure DevOps Pipeline triggered
        ↓
terraform init
        ↓
terraform validate
        ↓
terraform plan
        ↓
terraform apply
        ↓
Azure Infrastructure provisioned
```

> ⚠️ Edit note: Adjust the steps above if your actual pipeline YAML does something different (e.g., manual approval gate before apply, plan-only on PRs, etc.) — check `azure-pipelines.yml` and match this diagram to it exactly.

## Project structure

```
.
├── Environment/
│   ├── Dev/
│   └── Prod/
├── Modules/
│   └── (see Modules table above)
├── azure-pipelines.yml
├── .gitignore
└── LICENSE
```

## State management

Remote backend used for Terraform state (Azure Storage Account), enabling state locking and safe collaboration.

> ⚠️ Edit note: Only keep this section if you're actually using a remote backend (`backend "azurerm" {}` block in your `.tf` files). If state is local, remove this section — a false remote-backend claim is exactly the kind of detail an interviewer might probe on.

## Running locally

```bash
cd Environment/Dev
terraform init
terraform plan
terraform apply
```

## License

MIT — see [LICENSE](./LICENSE)

---

*Built by [Yesh Pal](https://github.com/yeshpal-devops) — Cloud & Infrastructure Engineer, learning Infrastructure as Code and DevOps automation on Azure.*
