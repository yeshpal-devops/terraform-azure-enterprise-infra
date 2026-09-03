# Terraform Azure Enterprise Infrastructure

<p align="center">
  <img src="https://img.shields.io/badge/Microsoft%20Azure-Cloud-0078D4?logo=microsoftazure&logoColor=white" alt="Azure" />
  <img src="https://img.shields.io/badge/Terraform-IaC-7B42BC?logo=terraform&logoColor=white" alt="Terraform" />
  <img src="https://img.shields.io/badge/Azure%20DevOps-CI%2FCD-0078D7?logo=azuredevops&logoColor=white" alt="Azure DevOps" />
  <img src="https://img.shields.io/badge/AKS-Kubernetes-326CE5?logo=kubernetes&logoColor=white" alt="AKS" />
  <img src="https://img.shields.io/badge/Key%20Vault-Security-16A34A?logo=microsoftazure&logoColor=white" alt="Key Vault" />
  <img src="https://img.shields.io/badge/Monitoring-Log%20Analytics-5C2D91?logo=microsoftazure&logoColor=white" alt="Monitoring" />
</p>

> **Production-style Azure Infrastructure as Code portfolio project** built with reusable Terraform modules, environment separation, secure administration, secrets management, Kubernetes and observability.

![Azure Architecture](./docs/architecture.svg)

## 🚀 Project Overview

This project demonstrates how to design and manage a modular Azure environment with Terraform instead of manually creating cloud resources.

### Current Azure resources

| Area | Resources |
|---|---|
| 🌐 Networking | VNet, subnets, NICs, NSG structure |
| 🔐 Security | Key Vault, Azure Bastion, secure secret injection |
| 🖥️ Compute | Linux Virtual Machines |
| 🗄️ Data | Azure SQL Server + Database |
| 📦 Storage | Azure Storage Account |
| 🐳 Containers | Azure Container Registry (ACR) |
| ☸️ Kubernetes | Azure Kubernetes Service (AKS) |
| 📊 Monitoring | Log Analytics Workspace |

## 🏗️ Architecture

The Dev environment uses a dedicated VNet with workload subnets and an `AzureBastionSubnet`. VM administration is designed through Azure Bastion rather than public IPs on the workload VMs. Key Vault provides credential storage, while SQL, Storage, ACR, AKS and Log Analytics provide application-platform capabilities.

```text
                         Azure Subscription
                                │
                         ┌──────▼──────┐
                         │ Resource    │
                         │    Group    │
                         └──────┬──────┘
                                │
        ┌───────────────────────┼────────────────────────┐
        │                       │                        │
   ┌────▼─────┐           ┌─────▼─────┐          ┌──────▼──────┐
   │   VNet   │           │ Key Vault  │          │ Log Analytics│
   │ 10.0.0/16│           │  Secrets   │          │  Monitoring  │
   └────┬─────┘           └────────────┘          └─────────────┘
        │
   ┌────┴───────────────────┐
   │                        │
┌──▼─────────┐       ┌──────▼──────────────┐
│ VM Subnets │       │ AzureBastionSubnet  │
│ VM-1 / VM-2│       │ Bastion + Public IP │
└────┬───────┘       └─────────────────────┘
     │
 ┌───┴────┐
 │        │
▼        ▼
VM-1    VM-2

 Azure SQL | Storage | ACR | AKS
```

📐 Full visual architecture: [`docs/architecture.svg`](./docs/architecture.svg)  
📖 Text architecture: [`docs/architecture.md`](./docs/architecture.md)

## 📁 Repository Structure

```text
.
├── Environment/
│   ├── Dev/
│   └── Prod/
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
│   ├── azurerm_kubernetes_cluster/
│   └── azurerm_log_analytics/
│
├── docs/
│   ├── architecture.md
│   └── architecture.svg
│
└── README.md
```

## 🔐 Security

- No plaintext passwords are stored in the tracked Dev `.tfvars` configuration.
- VM and SQL credentials are injected through sensitive Terraform variables.
- Azure Bastion is used for private VM administration.
- AKS uses a SystemAssigned managed identity by default.
- Terraform state must be protected because sensitive values can still exist in state.

```text
TF_VAR_vm_1_password
TF_VAR_vm_2_password
TF_VAR_sql_admin_password
```

> ⚠️ If the previously committed credentials were real, rotate/revoke them. Removing a secret from the latest commit does not remove it from Git history.

## 📊 Observability

A reusable **Log Analytics Workspace** is now included in the Dev environment as the foundation for centralized Azure monitoring and diagnostics.

The next monitoring step is to connect diagnostic settings from AKS, Key Vault, SQL and other resources to the workspace.

## ⚙️ Terraform Workflow

```bash
cd Environment/Dev
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

### Secure local variables

```bash
export TF_VAR_vm_1_password='********'
export TF_VAR_vm_2_password='********'
export TF_VAR_sql_admin_password='********'
```

For CI/CD, use a secure pipeline secret store rather than committing credentials.

## 🌍 Environment Strategy

```text
Environment/
├── Dev   → development / portfolio environment
└── Prod  → production-oriented environment structure
```

Dev and Prod are separated so resource inputs, state and authentication can evolve independently.

## 💼 What This Project Demonstrates

- Reusable Terraform module design
- Multi-environment infrastructure structure
- Azure networking and secure administration
- Key Vault-based secret management
- AKS and container platform provisioning
- Azure SQL and storage provisioning
- Centralized monitoring foundation with Log Analytics
- Infrastructure automation and repeatable deployments
- Security-conscious Infrastructure as Code practices

## 🛣️ Roadmap

- [x] Modular Terraform architecture
- [x] Dev environment
- [x] Azure Bastion + private VM administration
- [x] Key Vault secret handling
- [x] AKS + ACR
- [x] Azure SQL + Storage
- [x] Log Analytics monitoring foundation
- [ ] Diagnostic settings for Azure resources
- [ ] Private Endpoints + Private DNS
- [ ] OIDC / workload identity for CI/CD
- [ ] Checkov security scanning
- [ ] Azure Policy / policy-as-code
- [ ] Fully implemented Prod environment
- [ ] Production-grade remote backend per environment

## ⭐ Why this repository matters

This is intentionally more than a collection of Terraform examples. It is structured as an **enterprise-style Azure platform project** that demonstrates networking, security, compute, data, containers, Kubernetes, monitoring and Infrastructure as Code in one architecture.

---

**Terraform + Microsoft Azure** · Built by **Yesh Pal**
