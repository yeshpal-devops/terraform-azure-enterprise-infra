################################
# Resource Group
################################
dev_rg = {
  rg-1 = {
    name        = "dev-rg"
    location    = "East US"
    environment = "Development"
  }
}

################################
# Virtual Network
################################
dev_vnet = {
  vnet-1 = {
    name          = "dev-vnet"
    address_space = ["10.0.0.0/16"]
    dns_servers   = ["10.0.0.4", "10.0.0.5"]
    rg_key        = "rg-1"
  }
}

################################
# Subnets (2 VM + Bastion)
################################
dev_subnet = {
  subnet-1 = {
    name             = "dev-subnet-1"
    address_prefixes = ["10.0.1.0/24"]
    vnet_key         = "vnet-1"
  }

  subnet-2 = {
    name             = "dev-subnet-2"
    address_prefixes = ["10.0.2.0/24"]
    vnet_key         = "vnet-1"
  }

  bastion-subnet = {
    name             = "AzureBastionSubnet"
    address_prefixes = ["10.0.100.0/27"]
    vnet_key         = "vnet-1"
  }
}

################################
# Network Security Group
################################
dev_nsg = {
  nsg-1 = {
    name   = "dev-nsg"
    rg_key = "rg-1"
  }
}

################################
# Network Interfaces
################################
dev_nic = {
  nic-1 = {
    name       = "nic-vm-1"
    subnet_key = "subnet-1"
    rg_key     = "rg-1"
  }

  nic-2 = {
    name       = "nic-vm-2"
    subnet_key = "subnet-2"
    rg_key     = "rg-1"
  }
}

################################
# Virtual Machines (Passwords from KV)
################################
dev_vm = {
  vm-1 = {
    name        = "dev-vm-1"
    size        = "Standard_B2s"
    nic_key     = "nic-1"
    admin_user  = "azureuser"
    kv_secret   = "vm-1-password"
    rg_key      = "rg-1"
  }

  vm-2 = {
    name        = "dev-vm-2"
    size        = "Standard_B2s"
    nic_key     = "nic-2"
    admin_user  = "azureuser"
    kv_secret   = "vm-2-password"
    rg_key      = "rg-1"
  }
}

################################
# Public IP (ONLY Bastion)
################################
dev_public_ip = {
  pip-bastion = {
    name              = "pip-bastion-dev"
    allocation_method = "Static"
    rg_key            = "rg-1"
  }
}

################################
# Bastion Host
################################
dev_bastion = {
  bastion-1 = {
    name          = "dev-bastion"
    subnet_key    = "bastion-subnet"
    public_ip_key = "pip-bastion"
    rg_key        = "rg-1"
  }
}

################################
# Key Vault
################################
dev_keyvault = {
  kv-1 = {
    name                        = "dev-keyvault"
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
    sku                         = "standard"
    rg_key                      = "rg-1"
  }
}

################################
# Key Vault Secrets
################################
vault_secret = {
  vm-1-password = {
    name  = "vm-1-password"
    value = "DevSecOps@25"
  }

  vm-2-password = {
    name  = "vm-2-password"
    value = "DevSecOps@25"
  }

  sql-admin-password = {
    name  = "sql-admin-password"
    value = "P@ssword1234!"
  }
}

################################
# SQL Server (Password from KV)
################################
dev_sql_server = {
  sql = {
    name       = "dev-sql-server"
    admin_user = "sqladmin"
    kv_secret  = "sql-admin-password"
    rg_key     = "rg-1"
  }
}

################################
# SQL Database
################################
dev_sql_database = {
  db = {
    name       = "dev-database"
    server_key = "sql"
    sku_name   = "Basic"
  }
}

################################
# Storage Account
################################
dev_storage = {
  stg-1 = {
    name                     = "devstorageacct01"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    rg_key                   = "rg-1"
  }
}

################################
# Azure Container Registry
################################
dev_acr = {
  acr-1 = {
    name          = "appcontainersdev"
    sku           = "Premium"
    admin_enabled = false
    rg_key        = "rg-1"

    georeplications = [
      {
        location                = "East US"
        zone_redundancy_enabled = true
      },
      {
        location                = "North Europe"
        zone_redundancy_enabled = true
      }
    ]
  }
}

################################
# AKS Cluster
################################
dev_aks = {
  aks-1 = {
    name       = "dev-aks"
    dns_prefix = "devaks"
    node_count = 3
    vm_size    = "Standard_B2s"
    rg_key     = "rg-1"
  }
}
