# Terraform Azure Enterprise Infrastructure

![Azure](https://img.shields.io/badge/Microsoft%20Azure-Cloud-0078D4?logo=microsoftazure&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-IaC-7B42BC?logo=terraform&logoColor=white)
![Azure DevOps](https://img.shields.io/badge/Azure%20DevOps-CI%2FCD-0078D7?logo=azuredevops&logoColor=white)
![AKS](https://img.shields.io/badge/AKS-Kubernetes-326CE5?logo=kubernetes&logoColor=white)
![Security](https://img.shields.io/badge/Security-Key%20Vault-16A34A?logo=microsoftazure&logoColor=white)

> **Production-style Azure Infrastructure as Code portfolio project** built with reusable Terraform modules, environment separation, secure administration, secrets management and core Azure platform services.

![Azure Architecture](./docs/architecture.svg)

## 🚀 Project Overview

This repository demonstrates how a cloud infrastructure engineer can design and organize a modular Azure environment using Terraform rather than managing resources manually.

The current implementation includes:

- Modular Terraform architecture
- Separate Dev and Prod environment structure
- Azure Virtual Network and segmented subnets
- Network Interfaces and Network Security Group structure
- Azure Bastion for private VM administration
- Linux virtual machines
- Azure Key Vault for credential storage
- Azure SQL Server and Database
- Azure Storage Account
- Azure Container Registry (ACR)
- Azure Kubernetes Service (AKS)
- Secure secret injection for Terraform execution

## 🏗️ Architecture

The environment is organized around an Azure Resource Group with a dedicated VNet. Workloads are isolated into VM subnets, while Azure Bastion provides administrative access without exposing the workload VMs through public IP addresses.

Key platform services such as Key Vault, Azure SQL, Storage, ACR and AKS are provisioned through reusable modules.

### Architecture flow

```text
                         Azure Subscription
                                │
                         ┌──────▼──────┐
                         │ Resource    │
                         │    Group    │
                         └──────┬──────┘
                                │
              ┌─────────────────┴─────────────────┐
              │                                   │
        ┌─────▼─────┐                       ┌─────▼─────┐
        │    VNet   │                       │ Key Vault │
        │ 10.0.0/16 │                       │  Secrets  │
        └─────┬─────┘                       └───────────┘
              │
       ┌──────┴─────────┐
       │                │
 ┌─────▼─────┐   ┌──────▼──────────────┐
 │ VM Subnet │   │ AzureBastionSubnet   │
 │ VM-1/VM-2 │   │ Bastion + Public IP  │
 └─────┬─────┘   └─────────────────────┘
       │
  ┌────┴────┐
  │         │
┌─▼────┐ ┌──▼────┐
│ VM-1  │ │ VM-2  │
└───────┘ └───────┘

   Azure SQL | Storage | ACR | AKS
```

For the visual architecture diagram, see [`docs/architecture.svg`](./docs/architecture.svg). A text version is also available in [`docs/architecture.md`](./docs/architecture.md).

## 📁 Repository Structure

```text
.
├── Environment/
│   ├── Dev/
│   │   ├── main.tf
│   │   ├── provider.tf
│   │   ├── variables.tf
│   │   └── terraform.tfvars
│   └── Prod/
│       ├── main.tf
│       ├── provider.tf
│       ├── variables.tf
│       └── terraform.tfvars
│
├── Modules/
│   ├── azurerm_resource_group/
│   ├── azurerm_virtual_network/
│   ├── azurerm_network_interface/
│   ├── azurerm_public_ip/
│   ├── azurerm_key_vault/
│   ├── azurerm_virtual_machine/
│   ├── azurerm_bastion_host/
│   ├── azurerm_mssql_server/
│   ├── azurerm_mssql_database/
│   ├── azurerm_storage_account/
│   ├── azurerm_container_registry/
│   └── azurerm_kubernetes_cluster/
│
├── docs/
│   ├── architecture.md
│   └── architecture.svg
│
├── .gitignore
└── README.md
```

## 🔐 Security & Secret Management

Credentials are **not stored as plaintext values in the tracked Dev tfvars configuration**.

Secrets are expected to be supplied securely through Terraform variables such as:

```text
TF_VAR_vm_1_password
TF_VAR_vm_2_password
TF_VAR_sql_admin_password
```

For CI/CD, use a secure secret store or pipeline secret variables. Protect Terraform state because sensitive values may still be represented in state even when input variables are marked sensitive.

> ⚠️ Previously committed credentials should be rotated/revoked if they were real. Removing a secret from the latest file does not remove it from Git history.

## ⚙️ Terraform Workflow

```bash
cd Environment/Dev
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

### Secure variable example

```bash
export TF_VAR_vm_1_password='********'
export TF_VAR_vm_2_password='********'
export TF_VAR_sql_admin_password='********'
```

## 🌍 Environment Strategy

```text
Environment/
├── Dev   → development / learning environment
└── Prod  → production-oriented environment structure
```

The environment folders are intentionally separated so that resource inputs, state and authentication configuration can evolve independently.

## 💼 What This Project Shows Interviewers

- How to structure reusable Terraform modules
- How to separate infrastructure by environment
- How to design Azure networking and private administrative access
- How to handle secrets more securely
- How to provision both traditional VM workloads and container platforms
- How to organize Terraform for repeatable cloud deployments
- How Azure services can be composed into one enterprise-style environment

## 🧩 Future Enhancements

The next logical production-grade additions are:

- Terraform remote backend configuration per environment
- Azure DevOps pipeline with `fmt`, `validate`, `plan`, approval and `apply`
- OIDC/workload identity for pipeline authentication
- Terraform security scanning with Checkov or tfsec
- Azure Monitor / Log Analytics integration
- Managed identities for Azure workloads
- Private endpoints and tighter network isolation
- Policy-as-code and Azure Policy controls
- Fully implemented Prod resource inputs and deployment workflow

## 📌 Project Status

**Development / portfolio project — actively improving toward a production-grade Azure IaC reference implementation.**

---

Built with **Terraform + Microsoft Azure** by Yesh Pal.
