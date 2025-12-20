resource "azurerm_virtual_network" "network" {
  for_each = var.dev_vnet
  name                = each.value.name
  location            = var.dev_rg[each.value.rg_key].location
  resource_group_name = var.dev_rg[each.value.rg_key].name
  address_space       = each.value.address_space
  dns_servers         = each.value.dns_servers

  dynamic "subnet" {
    for_each = [for s in values(var.dev_subnet) : s if lookup(s, "vnet_key", "") == each.key]
    content {
      name             = subnet.value.name
      address_prefixes = subnet.value.address_prefixes
      security_group   = lookup(subnet.value, "network_security_group_id", null)
    }
  }

  tags = {
    environment = var.dev_rg[each.value.rg_key].environment
  }
}