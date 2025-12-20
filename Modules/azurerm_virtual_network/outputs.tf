locals {
  vnet_subnet_map = {
    for v_k, v in azurerm_virtual_network.network :
    v_k => { for sn in v.subnet : sn.name => sn.id }
  }
}

output "subnet_ids" {
  value = {
    for s_k, s in var.dev_subnet :
    s_k => lookup(local.vnet_subnet_map[s.vnet_key], s.name, null)
  }
}
