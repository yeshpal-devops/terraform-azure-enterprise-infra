data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "vault" {
  for_each = var.dev_keyvault

  name                = each.value.name
  location            = var.dev_rg[each.value.rg_key].location
  resource_group_name = var.dev_rg[each.value.rg_key].name

  tenant_id                   = data.azurerm_client_config.current.tenant_id
  enabled_for_disk_encryption = each.value.enabled_for_disk_encryption
  soft_delete_retention_days  = each.value.soft_delete_retention_days
  purge_protection_enabled    = each.value.purge_protection_enabled
  sku_name                    = each.value.sku

  rbac_authorization_enabled = true
}


resource "azurerm_key_vault_secret" "secret" {
  for_each = var.vault_secret

  name  = each.value.name
  value = each.value.value

  key_vault_id = values(azurerm_key_vault.vault)[0].id

}
