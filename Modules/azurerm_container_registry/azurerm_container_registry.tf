resource "azurerm_container_registry" "acr" {
  for_each = var.dev_acr

  name                = each.value.name
  resource_group_name = var.dev_rg[each.value.rg_key].name
  location            = var.dev_rg[each.value.rg_key].location
  sku                 = each.value.sku
  admin_enabled       = each.value.admin_enabled

  dynamic "georeplications" {
    for_each = [for g in lookup(each.value, "georeplications", []) : g if lower(g.location) != lower(var.dev_rg[each.value.rg_key].location)]
    content {
      location                = georeplications.value.location
      zone_redundancy_enabled = georeplications.value.zone_redundancy_enabled
    }
  }
}
