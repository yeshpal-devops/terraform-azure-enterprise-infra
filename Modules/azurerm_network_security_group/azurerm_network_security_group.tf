resource "azurerm_network_security_group" "nsg" {
  for_each = var.dev_nsg
  name                = each.value.name
  location            = var.dev_rg[each.value.rg_key].location
  resource_group_name = var.dev_rg[each.value.rg_key].name

  security_rule {
    name                       = lookup(each.value, "name", "allow-ssh")
    priority                   = lookup(each.value, "priority", 100)
    direction                  = lookup(each.value, "direction", "Inbound")
    access                     = lookup(each.value, "access", "Allow")
    protocol                   = lookup(each.value, "protocol", "Tcp")
    source_port_range          = lookup(each.value, "source_port_range", "*")
    destination_port_range     = lookup(each.value, "destination_port_range", "*")
    source_address_prefix      = lookup(each.value, "source_address_prefix", "*")
    destination_address_prefix = lookup(each.value, "destination_address_prefix", "*")
  }

  tags = {
    environment = lookup(var.dev_rg[each.value.rg_key], "environment", "")
  }
}