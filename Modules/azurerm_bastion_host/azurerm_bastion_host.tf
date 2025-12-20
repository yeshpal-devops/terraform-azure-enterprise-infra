resource "azurerm_bastion_host" "bastion" {
  for_each = var.dev_bastion
  name                = each.value.name
  location            = var.dev_rg[each.value.rg_key].location
  resource_group_name = var.dev_rg[each.value.rg_key].name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.dev_subnet_ids[each.value.subnet_key]
    public_ip_address_id = var.dev_public_ip_ids[each.value.public_ip_key]
  }
}