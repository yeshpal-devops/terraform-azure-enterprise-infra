resource "azurerm_log_analytics_workspace" "workspace" {
  for_each = var.log_analytics

  name                = each.value.name
  location            = var.dev_rg[each.value.rg_key].location
  resource_group_name = var.dev_rg[each.value.rg_key].name
  sku                 = lookup(each.value, "sku", "PerGB2018")
  retention_in_days   = lookup(each.value, "retention_in_days", 30)

  tags = {
    environment = var.dev_rg[each.value.rg_key].environment
    managed_by  = "terraform"
  }
}
