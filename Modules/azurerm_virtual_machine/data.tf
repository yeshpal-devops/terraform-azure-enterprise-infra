########################################
# Read secrets from Key Vault
########################################
data "azurerm_key_vault_secret" "secret" {
  for_each = var.dev_vm

  name         = each.value.kv_secret
  key_vault_id = var.key_vault_id[each.key]
}

########################################
# Read Network Interface
########################################
data "azurerm_network_interface" "nic" {
  for_each = var.dev_vm

  name                = each.value.nic_key
  resource_group_name = each.value.resource_group_name
}
