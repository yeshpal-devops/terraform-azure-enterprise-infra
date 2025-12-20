resource "azurerm_storage_account" "stg" {
  for_each = var.dev_storage
  name                     = each.value.name
  resource_group_name      = var.dev_rg[each.value.rg_key].name
  location                 = var.dev_rg[each.value.rg_key].location
  account_tier             = each.value.account_tier                                                                                                      #Standard
  account_replication_type = each.value.account_replication_type                                                                                         #"GRS"

  tags = {
    environment = var.dev_rg[each.value.rg_key].environment
  }
}