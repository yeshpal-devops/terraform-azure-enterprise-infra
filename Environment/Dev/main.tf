############################
# Resource Group
############################
module "rg" {
  source = "../../Modules/azurerm_resource_group"
  dev_rg = var.dev_rg
}

############################
# Virtual Network + Subnets
############################
module "vnet" {
  depends_on = [module.rg]
  source     = "../../Modules/azurerm_virtual_network"

  dev_vnet   = var.dev_vnet
  dev_subnet = var.dev_subnet
  dev_rg     = var.dev_rg
}

############################
# Network Interface (VMs)
############################
module "nic" {
  depends_on = [module.vnet]
  source     = "../../Modules/azurerm_network_interface"

  dev_nic = var.dev_nic
  dev_rg  = var.dev_rg
  dev_subnet_ids = module.vnet.subnet_ids
}

############################
# Public IP (ONLY for Bastion)
############################
module "pip" {
  depends_on    = [module.rg]
  source        = "../../Modules/azurerm_public_ip"

  dev_public_ip = var.dev_public_ip
  dev_rg        = var.dev_rg
}

############################
# Key Vault + Secrets
############################
module "key_vault" {
  depends_on   = [module.rg]
  source       = "../../Modules/azurerm_key_vault"

  dev_keyvault = var.dev_keyvault
  vault_secret = var.vault_secret
  dev_rg       = var.dev_rg
}

############################
# Virtual Machines (Passwords from Key Vault)
############################

locals {
  dev_vm_enriched = {
    for k, v in var.dev_vm : k => merge(v, {
      resource_group_name = var.dev_rg[v.rg_key].name,
      location            = var.dev_rg[v.rg_key].location
    })
  }

  vm_key_vault_map = {
    for k in keys(var.dev_vm) : k => module.key_vault.key_vault_id["kv-1"]
  }
}

module "vm" {
  depends_on = [module.nic, module.key_vault]
  source     = "../../Modules/azurerm_virtual_machine"

  dev_vm        = local.dev_vm_enriched
  key_vault_id  = local.vm_key_vault_map

}


############################
# Azure Bastion Host
############################
module "azure_bastion" {
  depends_on = [module.vnet, module.pip]
  source     = "../../Modules/azurerm_bastion_host"

  dev_bastion = var.dev_bastion
  dev_rg = var.dev_rg
  dev_subnet_ids = module.vnet.subnet_ids
  dev_public_ip_ids = module.pip.public_ip_ids
}

############################
# SQL Server (Password from Key Vault)
############################
module "sql_server" {
  depends_on     = [module.key_vault]
  source         = "../../Modules/azurerm_mssql_server"

  dev_sql_server = var.dev_sql_server
  dev_rg         = var.dev_rg
  key_vault_id   = module.key_vault.key_vault_id["kv-1"]
}

############################
# SQL Database
############################

locals {
  db_server_ids = {
    for db_k, db_v in var.dev_sql_database :
    db_k => module.sql_server.sql_server_ids[db_v.server_key]
  }
}

module "sql_database" {
  depends_on           = [module.sql_server]
  source               = "../../Modules/azurerm_mssql_database"

  dev_sql_database     = var.dev_sql_database
  dev_sql_server_ids   = local.db_server_ids
}

############################
# Storage Account
############################
module "storage_account" {
  depends_on  = [module.rg]
  source      = "../../Modules/azurerm_storage_account"

  dev_storage = var.dev_storage
  dev_rg      = var.dev_rg
}

############################
# Azure Container Registry
############################
module "container_registry" {
  depends_on = [module.rg]
  source     = "../../Modules/azurerm_container_registry"

  dev_acr = var.dev_acr
  dev_rg  = var.dev_rg
}

############################
# AKS Cluster
############################
module "kubernetes_cluster" {
  depends_on = [module.vnet]
  source     = "../../Modules/azurerm_kubernetes_cluster"

  dev_aks = var.dev_aks
  dev_rg  = var.dev_rg
}
