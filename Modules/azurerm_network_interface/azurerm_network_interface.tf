resource "azurerm_network_interface" "nic" {
  for_each = var.dev_nic
  name                = each.value.name
  location            = var.dev_rg[each.value.rg_key].location
  resource_group_name = var.dev_rg[each.value.rg_key].name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.dev_subnet_ids[each.value.subnet_key]
    private_ip_address_allocation = lookup(each.value, "private_ip_address_allocation", "Dynamic")
  }
}