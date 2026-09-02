variable "dev_rg" {
  description = "Development resource groups."
  type        = map(any)
}

variable "dev_vnet" {
  description = "Development virtual network configuration."
  type        = map(any)
}

variable "dev_subnet" {
  description = "Development subnet configuration."
  type        = map(any)
}

variable "dev_nsg" {
  description = "Development network security groups."
  type        = map(any)
}

variable "dev_public_ip" {
  description = "Development public IP configuration."
  type        = map(any)
}

variable "dev_nic" {
  description = "Development network interface configuration."
  type        = map(any)
}

variable "dev_vm" {
  description = "Development VM configuration."
  type        = map(any)
}

variable "dev_bastion" {
  description = "Development Azure Bastion configuration."
  type        = map(any)
}

variable "dev_storage" {
  description = "Development storage account configuration."
  type        = map(any)
}

variable "dev_acr" {
  description = "Development Azure Container Registry configuration."
  type        = map(any)
}

variable "dev_aks" {
  description = "Development AKS configuration."
  type        = map(any)
}

variable "dev_keyvault" {
  description = "Development Key Vault configuration."
  type        = map(any)
}

variable "dev_sql_server" {
  description = "Development SQL Server configuration."
  type        = map(any)
}

variable "dev_sql_database" {
  description = "Development SQL database configuration."
  type        = map(any)
}

variable "vm_1_password" {
  description = "Password for development VM 1. Inject through TF_VAR_vm_1_password or a CI secret."
  type        = string
  sensitive   = true
}

variable "vm_2_password" {
  description = "Password for development VM 2. Inject through TF_VAR_vm_2_password or a CI secret."
  type        = string
  sensitive   = true
}

variable "sql_admin_password" {
  description = "Password for the development SQL administrator. Inject through TF_VAR_sql_admin_password or a CI secret."
  type        = string
  sensitive   = true
}
