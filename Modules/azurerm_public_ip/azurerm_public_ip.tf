resource "azurerm_public_ip" "pip" {
  for_each = var.dev_public_ip
  name                = each.value.name
  resource_group_name = var.dev_rg[each.value.rg_key].name
  location            = var.dev_rg[each.value.rg_key].location
  allocation_method   = each.value.allocation_method

  tags = {
    environment = var.dev_rg[each.value.rg_key].environment
  }
}