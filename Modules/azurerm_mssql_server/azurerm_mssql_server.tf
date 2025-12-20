resource "azurerm_mssql_server" "sql-server" {
  for_each = var.dev_sql_server
  name                         = each.value.name
  resource_group_name          = var.dev_rg[each.value.rg_key].name
  location                     = var.dev_rg[each.value.rg_key].location
  version                      = lookup(each.value, "version", "12.0")
  administrator_login          = lookup(each.value, "admin_user", "sqladmin")
  administrator_login_password = lookup(data.azurerm_key_vault_secret.pw, each.key, {}).value
  minimum_tls_version          = lookup(each.value, "minimum_tls_version", "1.2")

  dynamic "azuread_administrator" {
    for_each = contains(keys(each.value), "azuread_administrator") ? [each.value.azuread_administrator] : []
    content {
      login_username = azuread_administrator.value.login_username
      object_id      = azuread_administrator.value.object_id
    }
  }

  tags = {
    environment = var.dev_rg[each.value.rg_key].environment
  }
}

data "azurerm_key_vault_secret" "pw" {
  for_each     = var.dev_sql_server
  name         = each.value.kv_secret
  key_vault_id = var.key_vault_id
}